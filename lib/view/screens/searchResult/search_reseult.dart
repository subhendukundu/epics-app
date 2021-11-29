import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:epics/services/userinfo_service.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/userProfile/userprofile.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<UserInfoModel> allUsers = <UserInfoModel>[];
  List<UserInfoModel> searchList = <UserInfoModel>[];

  @override
  void initState() {
    super.initState();
    UserInfoService().getAllUsers().then((val) {
      val.data.forEach((e) {
        UserInfoModel model = UserInfoModel.fromMap(e);
        allUsers.add(model);
      });
    });
  }

  static String query;
  @override
  TextEditingController searchController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              elevation: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: TextField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    query = value.toUpperCase();
                    setState(() {
                      searchList = allUsers.where((note) {
                        var noteTile = note.userName.toUpperCase();

                        return noteTile.contains(query);
                      }).toList();
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => searchList[index].userId !=
                              Get.find<AuthController>().userUid.value
                          ? Get.to(() => OtherUserProfile(
                                userModel: searchList[index],
                              ))
                          : Get.to(() => UserProfile()),
                      leading: searchList[index].userAvatar != null
                          ? GestureDetector(
                              onTap: () => Get.to(
                                () => FullImagePreview(
                                    imageUrl: NETWORK_IMAGE_URL +
                                        '${searchList[index].userAvatar}',
                                    blurHash: searchList[index].blurHash),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: BlurHash(
                                    image: NETWORK_IMAGE_URL +
                                        '${searchList[index].userAvatar}',
                                    hash: searchList[index].blurHash,
                                  ),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  'assets/default.jpeg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      title: Text(searchList[index].userName,
                          style: Theme.of(context).textTheme.bodyText1),
                      // subtitle: Text(searchList[index].phone,
                      //     style: Theme.of(context).textTheme.caption),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
