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
      'followers': [],
      'following': [],
    };
  }
}
