import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profileURL']),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 1),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['comment']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      DateFormat.yMMMMd().format(
                        widget.snap['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LikeAnimation(
              isAnimating: widget.snap['likes'].contains(user.uid),
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await FireStoreMethods().likeComment(
                      widget.snap['uid'],
                      widget.snap['postID'],
                      widget.snap['commentID'],
                      widget.snap['likes']);
                },
                icon: widget.snap['likes'].contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
