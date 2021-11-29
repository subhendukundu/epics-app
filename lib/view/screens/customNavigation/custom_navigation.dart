import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/view/screens/addPost/add_post.dart';
import 'package:epics/view/screens/homepage/home_page.dart';
import 'package:epics/view/screens/profile/user_profile.dart';
import 'package:epics/view/screens/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:epics/view/screens/notifications/notification_screen.dart';
import 'components/fab_bottom_navigation.dart';

// ignore: must_be_immutable
class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _list = [
    HomePage(),
    SearchPage(),
    NotificationScreen(),
    UserProfile(),
  ];

  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey[300],
        backgroundColor: Colors.white,
        selectedColor: Color(0xFFD226AB),
        // Color(0xFFD226AB),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.home_outlined),
          FABBottomAppBarItem(iconData: Icons.search),
          FABBottomAppBarItem(iconData: Icons.notifications_none_outlined),
          FABBottomAppBarItem(iconData: Icons.person_outlined),
        ],
      ),
      body: _list[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        focusElevation: 6,
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            color: Colors.white,
            // size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xFFB817D9),
                Color(0xFFD226AB),
              ])),
        ),
        onPressed: () {
          Get.to(() => SingleImageUpload(),
              transition: Transition.downToUp,
              duration: Duration(
                milliseconds: 400,
              ));
        },
      ),
    );
  }
}
