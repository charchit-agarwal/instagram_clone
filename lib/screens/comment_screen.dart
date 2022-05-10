import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({Key? key,required this.snap}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profileURL),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Comment as ${user.username}',
                        border: InputBorder.none),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FireStoreMethods().postComment(
                      _controller.text,
                      widget.snap['postID'],
                      user.username,
                      user.profileURL,
                      user.uid);
                },
                child: Text(
                  'Comment',
                  style: TextStyle(color: blueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
