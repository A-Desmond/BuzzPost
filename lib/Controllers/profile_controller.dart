import 'package:buzpost/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getData();
    followUser();
  }

  getData() async {
    List<String> thumbnail = [];
    var myvideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myvideos.docs.length; i++) {
      thumbnail.add((myvideos.docs[i].data() as dynamic)['thumbnail']);
    }
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['photoUrl'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var items in myvideos.docs) {
      likes += (items.data()['likes'] as List).length;
    }

    var followersDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    var followeringDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followering')
        .get();

    followers = followersDoc.docs.length;
    following = followeringDoc.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'photoUrl': profilePhoto,
      'name': name,
      'thumbnail': thumbnail,
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

        if(!doc.exists){
          await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .set({});
         await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('following')
        .doc(_uid.value)
        .set({});
        _user.value.update('followers', (value) => (int.parse(value)+1).toString());
        }else{
            await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .delete();
         await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('followering')
        .doc(_uid.value)
        .delete();
        _user.value.update('followers', (value) => (int.parse(value)-1).toString());
        }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }


}
