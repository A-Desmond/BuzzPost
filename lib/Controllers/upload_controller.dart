import 'package:buzpost/Model/video_model.dart';
import 'package:buzpost/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  /// Compress video
  _compressVideo(String videopath) async {
    final compressVideo = await VideoCompress.compressVideo(
      videopath,
      quality: VideoQuality.MediumQuality,
    );
    return compressVideo!.file;
  }

  getThumnail(String path) async {
    final thumbnail = await VideoCompress.getFileThumbnail(path);
    return thumbnail;
  }

  //
  Future<String> _uploadVideoToStorage(String id, String path) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(path));
    TaskSnapshot snap = await uploadTask;
    String videoUrl = await snap.ref.getDownloadURL();
    return videoUrl;
  }

  Future<String> _uploadImageToStorage(String id, String path) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumnail(path));
    TaskSnapshot snap = await uploadTask;
    String videoUrl = await snap.ref.getDownloadURL();
    return videoUrl;
  }

  //Video Upload
  uploadVideo(
      String productName, String productDescription, String videoPath) async {
    try {
      if (productName.isNotEmpty &&
          productDescription.isNotEmpty &&
          videoPath.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid;
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();
        var allDoc = await firestore.collection('videos').get();
        int len = allDoc.docs.length;
        String videoUrl = await _uploadVideoToStorage('videos $len', videoPath);
        String thumbnail = await _uploadImageToStorage('videos $len', videoPath);
        VideoModel videoModel = VideoModel(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: 'videos $len',
          likes: [],
          commentCount: 0,
          shareCount: 0,
          productName: productName,
          productDescription: productDescription,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePic: (userDoc.data()! as Map<String, dynamic>)['photoUrl'],
        );
        await firestore
            .collection('videos')
            .doc('videos $len')
            .set(videoModel.toJson());
        Get.back();
      } else {
        Get.snackbar('Error', 'Please fill the forms');
      }
    } catch (e) {
      Get.snackbar('Error Uploading video', e.toString(),
          backgroundColor: Colors.red);
    }
  }
}
