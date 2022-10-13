import 'dart:io';

import 'package:buzpost/Views/Screens/Upload%20Video/confirm_video.dart';
import 'package:buzpost/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

pickVideo(ImageSource src, BuildContext context) async {
  final  video = await ImagePicker().pickVideo(source: src);
  if (video != null) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfrimVideo(
              file: File(video.path),
              path: video.path,
            )));
  }
}

showOptions(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.gallery, context),
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.camera, context),
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: const [
                    Icon(Icons.close),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
}

class _UploadVideoState extends State<UploadVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptions(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: const BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                'UPLOAD VIDEO',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
