import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PlayProvider extends ChangeNotifier {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;

  Map<String, dynamic> game = {
    'status': false,
    'time': Duration(minutes: 2),
    'score': 0,
    'blue': 0,
    'green': 0,
    'yellow': 0,
    'red': 0,
  };

  Map<String, bool> numberStatus = {
    'blue': false,
    'red': false,
    'green': false,
    'yellow': false,
  };

  bool getNumberStatus(String field) {
    return this.numberStatus[field];
  }

  void setNumberStatus(String field, bool value) {
    this.numberStatus[field] = value;
    notifyListeners();
  }

  PlayProvider() {
    this.game['score'] = 0;
    this.game['blue'] = 0;
    this.game['green'] = 0;
    this.game['yellow'] = 0;
    this.game['red'] = 0;
    this.game['status'] = false;
    this.game['time'] = Duration(minutes: 2);
    this.numberStatus = {
      'blue': false,
      'red': false,
      'green': false,
      'yellow': false,
    };


    setCountDownTime();
  }

  Map<String, dynamic> getGameStatus() {
    return this.game;
  }

  play() {
    this.game['status'] = true;
    notifyListeners();
  }

  stop() {
    this.game['status'] = false;
    notifyListeners();
  }

  bool isPlay() {
    return this.game['status'];
  }

  Duration getCountdown() {
    return this.game['time'];
  }

  void addPoint(int point) {
    this.game['score'] += point;
    notifyListeners();
  }

  void addPointToKey(String key, int point) {
    this.game['score'] += point;
    this.game[key] += 1;
  }

  void reset() {
    this.game['score'] = 0;
    this.game['blue'] = 0;
    this.game['green'] = 0;
    this.game['yellow'] = 0;
    this.game['red'] = 0;
    notifyListeners();
  }

  int getScore() {
    return this.game['score'];
  }

  Map<String, dynamic> getGameData() {
    return this.game;
  }

  Future<void> setCountDownTime() async{
    final dayRound = await this.getDayRound();
    switch (dayRound) {
      case (1):
        this.game['time'] = Duration(minutes: 2);
        break;
      case (2):
        this.game['time'] = Duration(minutes: 3);
        break;
      case (3):
        this.game['time'] = Duration(minutes: 4);
        break;
      case (4):
        this.game['time'] = Duration(minutes: 5);
        break;
      default:
        this.game['time'] = Duration(minutes: 6);
    }
  }

  Future<int> getRound(String uniqueStr) async {
    final user = await auth.currentUser();
    QuerySnapshot data = await db
        .collection('game')
        .where('day_key', isEqualTo: uniqueStr)
        .where('uid', isEqualTo: user.uid)
        .getDocuments();

    return data.documents.length + 1;
  }

  Future<int> getDayRound() async {
    final user = await auth.currentUser();
    List<dynamic> tmp = new List<dynamic>();
    QuerySnapshot data = await db
        .collection('game')
        .where('uid', isEqualTo: user.uid)
        .orderBy('created_date')
        .getDocuments();

    data.documents.forEach((obj) {
      if (!this.isHasDataInArray(tmp, obj.data['day_key'])) {
        tmp.add(obj);
      }
    });

    int index = -1;
    String uniqueCurrent = await this.getUniqueStringByDate();

    for (int i = 0; i < tmp.length; i++) {
      if (tmp[i]['day_key'] == uniqueCurrent) {
        index = i;
        break;
      }
    }

    if(index == -1){
      index = tmp.length;
    }

    return index+1;
  }

  Future<List<dynamic>> isHasData(String uniqueStr) async {
    final user = await auth.currentUser();

    QuerySnapshot data = await db
        .collection('game')
        .where('day_key', isEqualTo: uniqueStr)
        .where('uid', isEqualTo: user.uid)
        .getDocuments();

    List<dynamic> tmp = [
      data.documents.length <= 0
          ? ''
          : data.documents[0].data['day_key'] == null
              ? ''
              : data.documents[0].data['day_key'],
      data.documents.length
    ];
    return tmp;
  }

  Future<String> getUniqueStringByDate() async {
    final date = new DateTime.now();
    final user = await auth.currentUser();

    return '${user.uid}-${date.day}-${date.month}-${date.year}';
  }

  Future<void> saveScore() async {
    final user = await auth.currentUser();
    final dateUniqueStr = await getUniqueStringByDate();

    List<dynamic> tmp = await isHasData(dateUniqueStr);

    if (tmp[1] > 0) {
      await db.collection("game").add({
        'day_key': tmp[0],
        'created_date': DateTime.now().toUtc().millisecondsSinceEpoch,
        'round': tmp[1] + 1,
        'score': this.game['score'],
        'uid': user.uid,
        'blue': this.game['blue'],
        'yellow': this.game['yellow'],
        'red': this.game['red'],
        'green': this.game['green'],
      });
    } else {
      await db.collection("game").add({
        'day_key': dateUniqueStr,
        'created_date': DateTime.now().toUtc().millisecondsSinceEpoch,
        'round': 1,
        'score': this.game['score'],
        'uid': user.uid,
        'blue': this.game['blue'],
        'yellow': this.game['yellow'],
        'red': this.game['red'],
        'green': this.game['green'],
      });
    }
  }

  bool isHasDataInArray(List<dynamic> items, String day_key) {
    for (int i = 0; i < items.length; i++) {
      if (items[i]['day_key'] == day_key) {
        return true;
      }
    }

    return false;
  }
}
