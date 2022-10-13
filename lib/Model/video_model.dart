import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String username;
  final String uid;
  final String id;
  final List likes;
  final int commentCount;
  final int shareCount;
  final String productName;
  final String productDescription;
  final String videoUrl;
  final String thumbnail;
  final String profilePic;

  VideoModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.productName,
    required this.productDescription,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePic,
  });

  Map<String, dynamic> toJson() => {
        'name': username,
        'uid': uid,
        'photoUrl': profilePic,
        'id': id,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'productName': productName,
        'productDescription': productDescription,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
      };

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
      username: snapshot['name'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      productName: snapshot['productName'],
      productDescription: snapshot['productDescription'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      profilePic: snapshot['photoUrl'],
    );
  }
}
