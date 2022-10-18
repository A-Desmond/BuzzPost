import 'dart:io';

import 'package:buzpost/Controllers/upload_controller.dart';
import 'package:buzpost/Views/Widgets/text_field.dart';
import 'package:buzpost/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfrimVideo extends StatefulWidget {
  final File file;
  final String path;
const   ConfrimVideo({
    super.key,
    required this.file,
    required this.path,
  });
  @override
  State<ConfrimVideo> createState() => _ConfrimVideoState();
}

final _productController = TextEditingController();
final _captionController = TextEditingController();

class _ConfrimVideoState extends State<ConfrimVideo> {
  late VideoPlayerController controller;
  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.file);
    controller.initialize();
    controller.play();
    controller.setVolume(0.5);
    controller.setLooping(true);
  }
 
 @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextInputField(
                        controller: _productController,
                        icon: Icons.production_quantity_limits,
                        label: 'Product Name',
                        isObscure: false,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextInputField(
                        controller: _captionController,
                        icon: Icons.description,
                        label: 'Description',
                        isObscure: false,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: buttonColor,
                      onPressed: ()=>uploadVideoController.uploadVideo(_productController.text,_captionController.text , widget.path),
                      child: const Text(
                        'POST NOW',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
