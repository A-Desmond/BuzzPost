import 'package:buzpost/Model/comment_model.dart';
import 'package:buzpost/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController{

final Rx<List<CommentModel>> _comments = Rx<List<CommentModel>>([]);
List<CommentModel> get comments => _comments.value;

String _postId = '';

updatePostId(String id){
  _postId = id;
  getComment();
}

getComment() async{
 _comments.bindStream(firestore.collection('videos').doc(_postId).collection('comment').snapshots().map((QuerySnapshot  query){
  List<CommentModel> reValue = [];
  for(var comment in query.docs){
    reValue.add(CommentModel.fromJson(comment));
  }
  return reValue;
 }));
}

postComment(String commentText) async{
 try{
   if(commentText.isNotEmpty){
    DocumentSnapshot userDoc  = await firestore.collection('users').doc(authController.user.uid).get();
    var allDocs  = await firestore.collection('videos').doc(_postId).collection('comment').get();
    int len = allDocs.docs.length;
    CommentModel comment = CommentModel(
      username: (userDoc.data() as dynamic)['name'],
      comment: commentText.trim(), 
      datePublished: DateTime.now(), 
      likes: [], 
      profilePhoto: (userDoc.data() as dynamic)['photoUrl'], 
      uid: (userDoc.data() as dynamic)['uid'], 
      id: 'Comment$len');
      await firestore.collection('videos').doc(_postId).collection('comment').doc('Comment$len').set(comment.toJson());
      DocumentSnapshot doc = await firestore.collection('videos').doc(_postId).get();
     await  firestore.collection('videos').doc(_postId).update({
        'commentCount': (doc.data()! as dynamic)['commentCount']+1
      });
  }
 } 
 catch(e){
  Get.snackbar('Error while commenting', e.toString(),colorText:Colors.white,backgroundColor: Colors.red );
 }
}

likeComment(String id) async {
   var uid = authController.user.uid;
   DocumentSnapshot doc = await firestore.collection('videos').doc(_postId).collection('comment').doc(id).get();
   if((doc.data()! as dynamic)['likes'].contains(uid)){
   await firestore.collection('videos').doc(_postId).collection('comment').doc(id).update({
      'likes': FieldValue.arrayRemove([uid])
    });
   }else{
    await firestore.collection('videos').doc(_postId).collection('comment').doc(id).update({
      'likes': FieldValue.arrayUnion([uid])
    });
   }
}
} 