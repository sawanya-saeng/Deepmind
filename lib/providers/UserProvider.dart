import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;
  Map<String, String> userData = {
    'uid': null,
    'name': null,
    'email': null,
    'image': null,
  };

  Map<String, bool> status = {
    'addStatus': false,
    'getStatus': false,
    'deleteStatus': false,
    'isAuth': false,
  };

  bool isAuth(){
    return this.status['isAuth'];
  }

  void setAuth(bool status){
    this.status['isAuth'] = status;
    notifyListeners();
  }

  bool addLoading() {
    return this.status['addStatus'];
  }

  void setAddLoading(bool status) {
    this.status['addStatus'] = status;
  }

  UserProvider() {
    this.status = {
      'addStatus': false,
      'getStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
  }

  String Name() {
    return this.userData['name'] == null ? 'No data' : this.userData['name'];
  }

  void setUserData(String uid, String name, String email, String image){
    this.userData = {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
    notifyListeners();
  }

  Future<dynamic> login(String username, String password) async{
    AuthResult result = await auth.signInWithEmailAndPassword(email: username, password: password);
    DocumentSnapshot userData = await db.collection("user").document(result.user.uid).get();

    this.setUserData(userData.documentID, userData.data['name'], userData.data['email'], userData.data['image']);
    notifyListeners();

    return result;
  }

  Future<dynamic> register(String name, String username, String password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(email: username, password: password);

    await db.collection("user").document(result.user.uid).setData({
      "uid": result.user.uid,
      "email": result.user.email,
      "name": name,
      "image": result.user.photoUrl
    });

    return result.user;
  }

  Future logout()async {
    await auth.signOut();
    this.userData = {
      'uid': null,
      'name': null,
      'email': null,
      'image': null,
    };

    this.status = {
      'addStatus': false,
      'getStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };

    notifyListeners();
  }
}
