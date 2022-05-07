import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List image,
  }) async {
    String res = 'Some error occured.';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          image != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profileURL = await StorageMethods()
            .uploadImageToStorage('profilePics', image, false);

        _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'email': email,
          'profileURL': profileURL,
          'bio': bio,
          'uid': cred.user!.uid,
          'followers': [],
          'following': [],
        });
        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
