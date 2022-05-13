import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost({
    required String description,
    required String username,
    required String uid,
    required String profileURL,
    required Uint8List image,
  }) async {
    String res = 'Some error occured.';
    try {
      String postID = Uuid().v1();
      String postURL =
          await StorageMethods().uploadImageToStorage('posts', image, true);
      Post post = Post(
          description: description,
          username: username,
          postID: postID,
          uid: uid,
          profileURL: profileURL,
          postURL: postURL,
          datePublished: DateTime.now(),
          likes: []);
      _firestore.collection('posts').doc(postID).set(post.toJson());
      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String uid, String postID, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  Future<void> postComment(String comment, String postID, String username,
      String profileURL, String uid) async {
    try {
      if (comment.isNotEmpty) {
        String commentID = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postID)
            .collection('comments')
            .doc(commentID)
            .set({
          'profileURL': profileURL,
          'uid': uid,
          'username': username,
          'postID': postID,
          'datePublished': DateTime.now(),
          'commentID': commentID,
          'comment': comment,
          'likes': [],
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> likeComment(
      String uid, String postID, String commentID, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore
            .collection('posts')
            .doc(postID)
            .collection('comments')
            .doc(commentID)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore
            .collection('posts')
            .doc(postID)
            .collection('comments')
            .doc(commentID)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  Future<void> deletePost(String postID, String uid) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('posts').doc(postID).get();
      if (snap['uid'] == uid) {
        await _firestore.collection('posts').doc(postID).delete();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followUser(String uid, String followID) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followID)) {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followID])
        });

        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followID])
        });

        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }
}
