import 'package:flutter/cupertino.dart';

class PlayProvider extends ChangeNotifier{
  Map<String ,dynamic> game =
  {
    'status' : false,
    'time' : Duration(minutes: 2),
  };

  PlayProvider()
  {
    this.game['status'] = false;
    this.game['time'] = Duration(minutes: 2);
  }

  Map<String ,dynamic> getGameStatus()
  {
    return this.game;
  }

  play()
  {
    this.game['status'] = true;
    this.game['time'] = Duration(seconds: 1);
    notifyListeners();
  }

  stop()
  {
    this.game['status'] = false;
    notifyListeners();
  }

  bool isPlay()
  {
    return
      this.game['status'] ;
  }

  Duration getCountdown(){
    return
      this.game['time'];
  }
}

