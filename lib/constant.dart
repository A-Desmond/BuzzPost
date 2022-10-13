import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'Controllers/auth_controller.dart';
import 'Views/Screens/Upload Video/upload_video.dart';
import 'Views/Screens/view_video.dart';

//Colors
const backgroundColor = Colors.black;
const buttonColor = Colors.cyan;
const borderColor = Colors.white;

//nav widgets
final pages = [
  VideoScreen(),
  const Center(
    child: Text('Search'),
  ),
  const UploadVideo(),
  const Center(
    child: Text('Messages'),
  ),
  const Center(
    child: Text('Profile'),
  ),
];

///FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;
var authController = AuthController.instance;
