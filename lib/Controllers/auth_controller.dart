import 'dart:io';

import 'package:buzpost/Model/user_model.dart';
import 'package:buzpost/Views/Screens/Auth/login.dart';
import 'package:buzpost/Views/Screens/Auth/register.dart';
import 'package:buzpost/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Views/Screens/home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;

  File? get profilePhoto => _pickedImage.value;
  User  get user  => _user.value!;
  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, initialScreen);
  }

  initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Register());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // PickImage
  void pickImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      Get.snackbar('Profile Picture', 'Image picked ✅');
    }
    _pickedImage = Rx<File?>(File(pickImage!.path));
  }

  // uploadImage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePicture')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  /// Reggister a user
  void register({
    required String name,
    required String email,
    required String password,
    required File? image,
  }) async {
    try {
      if (email.isNotEmpty &&
          name.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save credentials to firestore
        UserCredential credential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim());
        String downloadUrl = await _uploadToStorage(image);
        UserModel usermodel = UserModel(
          name: name,
          email: email,
          photoUrl: downloadUrl,
          uid: credential.user!.uid,);
        if (credential.user!.uid != null) {
          await firestore
              .collection('users')
              .doc(credential.user!.uid)
              .set(usermodel.userToJson());
        }
      } else {
        Get.snackbar('Error', 'Please fill all the forms',
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error creating Account', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
      } else {
        Get.snackbar('Error', 'Please fill all the forms',
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void signOut() {
    firebaseAuth.signOut();
  }
}
