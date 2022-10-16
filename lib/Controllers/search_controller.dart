import 'package:buzpost/Model/user_model.dart';
import 'package:buzpost/constant.dart';
import 'package:get/get.dart';


class SearchController extends  GetxController{
  final Rx<List<UserModel>> _searchUsers = Rx<List<UserModel>>([]);

  List<UserModel>  get searchUsers => _searchUsers.value;


  searchUser(String typedusername) async{
    _searchUsers.bindStream(
      firestore.collection('users').where('name',isGreaterThanOrEqualTo: typedusername).snapshots().map((query){
        List<UserModel> reValue = [];
        for(var names in query.docs){
          reValue.add(UserModel.fromSnap(names));
        }
        return reValue; 
      }
      )
    );
  }
}