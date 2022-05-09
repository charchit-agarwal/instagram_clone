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
      print(err.toString());
    }
  }
}
