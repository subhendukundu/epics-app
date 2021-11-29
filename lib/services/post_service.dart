import 'dart:io';
import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/model/models/comment_model.dart';
import 'package:epics/model/models/notificaion_model.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  addPost({PostsModel postModel, List<File> imageList}) async {
    List<String> uploadFileName = [];
    String bucketName = 'avatar';
    const fileOptions = FileOptions(upsert: true);

    for (int i = 0; i < imageList.length; i++) {
      // getting uniqueId
      var uniqueId = UniqueKey().toString().substring(2, 7);
      // file name that will store in database
      final fileName = 'public/$uniqueId.jpg';
      // getting blurhash of a image
      Uint8List pixels = await imageList[i].readAsBytes();
      // making image of upload fileName
      uploadFileName.add(fileName);
      try {
        await Supabase.instance.client.storage
            .from(bucketName)
            .uploadBinary(fileName, pixels, fileOptions: fileOptions)
            .then((value) {
          print(value.error);
        });
      } catch (e) {
        print(e.toString());
        Get.find<AddPostCtrl>().loading.value = false;
        Get.find<AddPostCtrl>()..posting.value = false;
        Get.snackbar('ERROR', e);
      }
    }
    postModel.imageList = uploadFileName;
    addUserPost(postModel);
  }

  addUserPost(PostsModel model) async {
    String tableName = 'posts';
    await Supabase.instance.client
        .from(tableName)
        .insert([model.toMap()])
        .execute()
        .then((value) {
          if (value.error == null) {
            final postController = Get.put(PostController());
            postController.onInit();
            // Get.find()<PostController>().onInit();
            Get.back();
          } else {
            Get.find<AddPostCtrl>().loading.value = false;
            Get.find<AddPostCtrl>()..posting.value = false;
            Get.snackbar('ERROR', value.error.message);
          }
        });
  }

  getPostComments(int postid) async {
    return await Supabase.instance.client
        .from('comments')
        .select('*,user_info(*)')
        .eq('post_id', postid)
        .execute();
  }

  addComment(CommentModel commentModel, String userto) async {
    if (userto != Get.find<AuthController>().userUid.value) {
      print('HERE');
      NotificationModel notificationModel = NotificationModel(
        userto: userto,
        userfrom: commentModel.userId,
        postId: commentModel.postId,
        notificationType: 'comment',
        createdOn: DateTime.now(),
      );
      Supabase.instance.client
          .from('notifications')
          .insert([notificationModel.toMap()]).execute();
    }
    return Supabase.instance.client
        .from('comments')
        .insert([commentModel.toMap()]).execute();
  }

  getCurrentUserPost(String userUid) async {
    return Supabase.instance.client.rpc('getpostswihtuid', params: {
      'currentuseruid': userUid,
    }).execute();
  }

  getUserDataFromUserUid(String userUid) async {
    return Supabase.instance.client
        .from('user_info')
        .select('*')
        .eq('user_id', userUid)
        .execute();
  }

  getPostsFromSearchPage() {
    return Supabase.instance.client.rpc('geteveryoneposts').execute();
  }

  getFollowingPosts(currentuseruid) async {
    return await Supabase.instance.client.rpc('getuserposts', params: {
      'currentuseruid': currentuseruid,
    }).execute();
  }

  insertLike(
      String authorUid, int postId, List<String> likedList, String userId) {
    if (authorUid != Get.find<AuthController>().userUid.value) {
      NotificationModel notificationModel = NotificationModel(
        userto: authorUid,
        userfrom: userId,
        postId: postId,
        notificationType: 'like',
        createdOn: DateTime.now(),
      );
      Supabase.instance.client
          .from('notifications')
          .insert([notificationModel.toMap()]).execute();
    }

    Supabase.instance.client
        .from('posts')
        .update({'likes_list': likedList})
        .eq('post_id', postId)
        .execute();

    Supabase.instance.client.from('likes').insert({
      'userid': userId,
      'post_id': postId,
      'created_on': DateTime.now().toIso8601String()
    }).execute();
  }

  deleteLike(int postId, List<String> likedList, String userId) {
    Supabase.instance.client
        .from('posts')
        .update({'likes_list': likedList})
        .eq('post_id', postId)
        .execute();
    Supabase.instance.client
        .from('likes')
        .delete()
        .eq('post_id', postId)
        .eq('userid', userId)
        .execute();
  }

  getLikesUser(int postId) async {
    return await Supabase.instance.client
        .from('likes')
        .select('*, user_info(*)')
        .eq('post_id', postId)
        .execute();
  }

  deleteUserPost(PostsModel postmodel) {
    print("ID DELETE ${postmodel.postId}");
    Supabase.instance.client
        .from('notifications')
        .delete()
        .eq('post_id', postmodel.postId)
        .execute()
        .then((value) {
      Supabase.instance.client
          .from('posts')
          .delete()
          .eq('post_id', postmodel.postId)
          .execute()
          .then((value) {
        // print(value.data.error.details);

        if (value.error == null) {
          final postCtrl = Get.put(PostController());
          postCtrl.onInit();
          Supabase.instance.client.storage
              .from('avatar')
              .remove(postmodel.imageList);
          Get.back();
        }
      });
    });
  }
}
