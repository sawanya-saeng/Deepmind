import 'package:flutter/cupertino.dart';

class StatProvider extends ChangeNotifier {
  List<Map<String, dynamic>> stats;

  StatProvider() {
    this.stats = [];
  }


}
