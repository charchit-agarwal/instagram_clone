import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String bio;
  final String uid;
  final String profileURL;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.username,
      required this.bio,
      required this.uid,
      required this.profileURL,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profileURL': profileURL,
      'bio': bio,
      'uid': uid,
      'followers': followers,
      'following': following,
    };
  }

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        profileURL: snapshot['profileURL'],
        followers: snapshot['followers'],
        following: snapshot['following']
        );
  }
}
