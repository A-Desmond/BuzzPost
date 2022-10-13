
import 'package:buzpost/Model/video_model.dart';
import 'package:buzpost/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewVideosController extends GetxController{
  final Rx<List<VideoModel>> _videoList =Rx<List<VideoModel>>([]);
  List<VideoModel> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firestore.collection('videos').snapshots().map((event) {
      List<VideoModel> retrivedVideo = [];
      for(var videos in event.docs){
        retrivedVideo.add(VideoModel.fromSnap(videos));
      }
      return retrivedVideo;
    }));
  }

 likeVideo(String id)async{
  DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
  var uid = authController.user.uid;
  if((doc.data()! as dynamic)['likes'].contains(uid)){
    await firestore.collection('videos').doc(id).update({
      'likes':FieldValue.arrayRemove([uid])
    });
  }else{
await firestore.collection('videos').doc(id).update({
      'likes':FieldValue.arrayUnion([uid])
    });
  }

}
}