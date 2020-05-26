import 'package:flutter/cupertino.dart';

class PlayProvider extends ChangeNotifier {
  Map<String, dynamic> game = {
    'status': false,
    'time': Duration(minutes: 2),
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
    this.game['time'] = Duration(seconds: 1);
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
}
