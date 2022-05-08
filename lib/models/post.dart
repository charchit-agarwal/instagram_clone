import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String username;
  final String postID;
  final String uid;
  final String postURL;
  final String profileURL;
  final datePublished;
  final likes;

  const Post(
      {required this.description,
      required this.username,
      required this.postID,
      required this.uid,
      required this.profileURL,
      required this.postURL,
      required this.datePublished,
      required this.likes});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'description': description,
      'postURL': postURL,
      'profileURL' : profileURL,
      'postID': postID,
      'uid': uid,
      'datePublished': datePublished,
      'likes': likes,
    };
  }

  static Post fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot['description'],
        username: snapshot['username'],
        postID: snapshot['postID'],
        uid: snapshot['uid'],
        postURL: snapshot['postURL'],
         profileURL: snapshot['profileURL'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes']);
  }
}
