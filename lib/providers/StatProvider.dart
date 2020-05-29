import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class StatProvider extends ChangeNotifier {
  List<Map<String, dynamic>> stats;
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;

  StatProvider() {
    this.stats = [];
  }

  void setStat(List<Map<String, dynamic>> data) {
    this.stats = data;
    notifyListeners();
  }

  Future<void> loadStat() async {
    final user = await auth.currentUser();
    List<Map<String, dynamic>> tmp = new List<Map<String, dynamic>>();
    QuerySnapshot data = await db
        .collection('game')
        .where('uid', isEqualTo: user.uid)
        .orderBy('created_date')
        .getDocuments();
    data.documents.forEach((obj) {
      tmp.add(obj.data);
    });

    this.setStat(tmp);
  }

  List<Map<String, dynamic>> getStatData() {
    List<dynamic> tmp = new List<Map<String, dynamic>>();

    for(int i=0;i<this.stats.length;i++){
      List<dynamic> check = this.isHasInStat(tmp, this.stats[i]['day_key']);

      if (check[1]) {
        tmp[check[0]]['items'].add(this.stats[i]);
      } else {
        tmp.add({
          'day_key': this.stats[i]['day_key'],
          'items': [this.stats[i]]
        });
      }
    }

    return tmp;
  }

  List<dynamic> isHasInStat(List<Map<String, dynamic>> items, String day_key) {
    for (int i = 0; i < items.length; i++) {
      if (items[i]['day_key'] == day_key) {
        return [i, true];
      }
    }

    return [0, false];
  }

  String dayKeyToDateStr(String uniqueStr){
    List<String> tmp = uniqueStr.split('-');

    return '${tmp[1]}-${tmp[2]}-${tmp[3]}';
  }
}