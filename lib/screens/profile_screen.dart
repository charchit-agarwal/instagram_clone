import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userdata = {};
  int postNum = 0;
  int followers = 0;
  int following = 0;
  bool isFollow = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      userdata = userSnap.data()!;
      postNum = postSnap.docs.length;
      followers = userdata['followers'].length;
      following = userdata['following'].length;
      isFollow = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      showSnackBar(err.toString(), context);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userdata['username']),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(userdata['profileURL']),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStatColumn(postNum, 'posts'),
                                buildStatColumn(followers, 'followers'),
                                buildStatColumn(following, 'following'),
                              ],
                            ),
                            FirebaseAuth.instance.currentUser!.uid == widget.uid
                                ? const FollowButton(
                                    backgroundColor: mobileBackgroundColor,
                                    borderColor: Colors.grey,
                                    text: 'Edit Profile',
                                    textColor: primaryColor)
                                : isFollow
                                    ? FollowButton(
                                        function: () async {
                                          await FireStoreMethods().followUser(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              userdata['uid']);
                                          setState(() {
                                            isFollow = false;
                                            --followers;
                                          });
                                        },
                                        backgroundColor: Colors.white,
                                        borderColor: Colors.grey,
                                        text: 'Unfollow',
                                        textColor: Colors.black)
                                    : FollowButton(
                                        function: () async {
                                          await FireStoreMethods().followUser(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              userdata['uid']);
                                          setState(() {
                                            isFollow = true;
                                            ++followers;
                                          });
                                        },
                                        backgroundColor: Colors.blue,
                                        borderColor: Colors.blue,
                                        text: 'Follow',
                                        textColor: Colors.white)
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      userdata['username'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      userdata['bio'],
                    ),
                  ),
                  const Divider(),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 1.5,
                                    crossAxisCount: 3,
                                    childAspectRatio: 1),
                            itemBuilder: (context, index) {
                              return Image(
                                image: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postURL'],
                                ),
                                fit: BoxFit.cover,
                              );
                            });
                      })
                ],
              ),
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: secondaryColor,
                fontSize: 18),
          ),
        ),
      ],
    );
  }
}
