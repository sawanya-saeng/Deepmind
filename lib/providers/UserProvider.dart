import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier{
  Map<String, String> data = {
    'name' : null,
    'image' : null
  };

  UserProvider() {
    this.data['name'] = 'taluew';
  }

  Name(){
    return this.data['name'];
  }
}

