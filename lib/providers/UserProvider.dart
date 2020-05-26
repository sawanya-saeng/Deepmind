import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier{
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;
  Map<String, String> data = {
    'name' : null,
    'image' : null
  };

  Map<String, bool> status = {
    'addStatus' : false,
    'getStatus' : false,
    'deleteStatus' : false,
  };

  bool addLoading(){
    return this.status['addStatus'];
  }

  void setAddLoading(bool status){
    this.status['addStatus'] = status;
  }

  UserProvider() {
    this.data['name'] = 'taluew';
  }

  String Name(){
    return this.data['name'];
  }

  Future<dynamic> login(String username, String password){

  }

  Future<dynamic> register(String username, String password)async {
    AuthResult result = await auth.createUserWithEmailAndPassword(email: username, password: password);

    return result.user;
  }
}

