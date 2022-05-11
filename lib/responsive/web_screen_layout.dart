import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
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

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              onPageChanged(0);
            },
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onPageChanged(1);
            },
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onPageChanged(2);
            },
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onPageChanged(3);
            },
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onPageChanged(4);
            },
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onPageChanged(5);
            },
            icon: Icon(
              Icons.messenger_outline_sharp,
              color: _page == 5 ? primaryColor : secondaryColor,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: homeScreenElements,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
