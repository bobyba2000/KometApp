import 'package:flutter/material.dart';

class EditKeyFrameModel extends ChangeNotifier {
  int editIndex;

  addEditIndex(int index) {
    this.editIndex = index;
    notifyListeners();
  }

  remove() {
    this.editIndex = null;
    notifyListeners();
  }
}
