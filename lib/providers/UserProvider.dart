import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();

  Map<String, String> userData = {
    'uid': null,
    'name': null,
    'email': null,
    'image': null,
  };

  Map<String, bool> status = {
    'addStatus': false,
    'getStatus': false,
    'updateStatus': false,
    'deleteStatus': false,
    'isAuth': false,
  };

  TextEditingController textFieldName(){
    return this.name;
  }

  bool isAuth() {
    return this.status['isAuth'];
  }

  void setAuth(bool status) {
    this.status['isAuth'] = status;
    notifyListeners();
  }

  bool addLoading() {
    return this.status['addStatus'];
  }

  bool loginStatus() {
    return this.status['getStatus'];
  }

  void setAddLoading(bool status) {
    this.status['addStatus'] = status;
  }

  UserProvider() {
    this.status = {
      'addStatus': false,
      'getStatus': false,
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
  }

  String Name() {
    return this.userData['name'] == null ? 'No data' : this.userData['name'];
  }

  void setUserData(String uid, String name, String email, String image) {
    this.userData = {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
    notifyListeners();
  }

  Future<dynamic> login(String username, String password) async {
    this.status = {
      'addStatus': false,
      'getStatus': true,
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
    notifyListeners();

    AuthResult result = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    DocumentSnapshot userData =
        await db.collection("user").document(result.user.uid).get();

    this.setUserData(userData.documentID, userData.data['name'],
        userData.data['email'], userData.data['image']);
    notifyListeners();

    this.name.text = userData.data['name'];
    return result;
  }

  Future<void> fetchMe()async{
    final user = await auth.currentUser();
    DocumentSnapshot userData = await db.collection("user").document(user.uid).get();

    this.setUserData(userData.documentID, userData.data['name'],
        userData.data['email'], userData.data['image']);
    notifyListeners();
  }

  Future<dynamic> register(
      String name, String username, String password) async {

    this.status = {
      'addStatus': true,
      'getStatus': false,
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
    notifyListeners();

    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: username, password: password);

    await db.collection("user").document(result.user.uid).setData({
      "uid": result.user.uid,
      "email": result.user.email,
      "name": name,
      "image": result.user.photoUrl
    });

    this.status = {
      'addStatus': false,
      'getStatus': false,
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
    notifyListeners();

    return result.user;
  }

  Future logout() async {
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
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };

    notifyListeners();
  }

  Future<void> updateName() async{
    final user = await auth.currentUser();

    this.status = {
      'addStatus': false,
      'getStatus': false,
      'updateStatus': true,
      'deleteStatus': false,
      'isAuth': false,
    };
    notifyListeners();

    await db.collection('user').document(user.uid).updateData({
      'name': this.name.text
    });

    this.status = {
      'addStatus': false,
      'getStatus': false,
      'updateStatus': false,
      'deleteStatus': false,
      'isAuth': false,
    };
    notifyListeners();
  }


  bool getUpdateStatus(){
    return this.status['updateStatus'];
  }
}
