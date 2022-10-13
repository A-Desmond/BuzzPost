import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String photoUrl;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.uid,
});

Map<String, dynamic> userToJson()=>{
  'name':name,
  'email': email,
  'uid': uid,
  'photoUrl': photoUrl,
};
static UserModel fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String, dynamic>;
  return UserModel(
  name: snapshot['name'],
  email: snapshot['email'], 
  photoUrl: snapshot['photoUrl'], 
  uid: snapshot['uid']
  );
}


}
