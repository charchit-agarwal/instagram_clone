import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenElements = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Notifications'),
  Text('Account'),
];
