import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: [
            Text('Home'),
            Text('Search'),
            Text('Post'),
            Text('Notifications'),
            Text('Account'),
          ],
          physics:const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
            onTap: navigationTapped,
            backgroundColor: mobileBackgroundColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  color: _page == 4 ? primaryColor : secondaryColor,
                ),
                backgroundColor: primaryColor,
              ),
            ]),
      ),
    );
  }
}
