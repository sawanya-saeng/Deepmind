import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PlayProvider extends ChangeNotifier {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;

  Map<String, dynamic> game = {
    'status': false,
    'time': Duration(minutes: 2),
    'score': 0
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
    this.game['status'] = false;
    this.game['time'] = Duration(minutes: 2);
    this.numberStatus = {
      'blue': false,
      'red': false,
      'green': false,
      'yellow': false,
    };
  }

  Map<String, dynamic> getGameStatus() {
    return this.game;
  }

  play() {
    this.game['status'] = true;
    this.game['time'] = Duration(seconds: 5);
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

  void reset() {
    this.game['score'] = 0;
    this.game['time'] = Duration(minutes: 2);
    notifyListeners();
  }

  int getScore() {
    return this.game['score'];
  }

  Future<void> saveScore() async {
    final user = await auth.currentUser();

    await db.collection("game").document(user.uid).setData({
      'created_date': DateTime.now().millisecondsSinceEpoch,
      'round': 1,
      'score': this.game['score'],
    });
  }
}
