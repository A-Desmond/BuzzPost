import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String username;
  final String comment;
  final datePublished;
  final List likes;
  final String profilePhoto;
  final String uid;
  final String id;

  CommentModel({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'name': username,
        'uid': uid,
        'photoUrl': profilePhoto,
        'datePublished': datePublished,
        'id': id,
        'likes': likes,
        'comment': comment,
      };

  static CommentModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      username: snap['name'],
      comment: snap['comment'],
      datePublished: snap['datePublished'],
      likes: snap['likes'],
      profilePhoto: snap['photoUrl'],
      uid: snap['uid'],
      id: snap['id'],
    );
  }
}
