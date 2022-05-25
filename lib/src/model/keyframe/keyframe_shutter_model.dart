import 'package:flutter/material.dart';

import 'keyframe_item.dart';

class KeyFrameModel extends ChangeNotifier {
  List<KeyFrameItem> shutterItemList = [];
  List<KeyFrameItem> isoItemList = [];
  List<KeyFrameItem> fstoptemList = [];
  List<KeyFrameItem> intervaltemList = [];

  removeItemShutter(List<KeyFrameItem> keyFrameItem) {
    keyFrameItem.forEach((element) {
      this.shutterItemList.remove(element);
    });

    notifyListeners();
  }

  removeItemFstop(List<KeyFrameItem> keyFrameItem) {
    keyFrameItem.forEach((element) {
      this.fstoptemList.remove(element);
    });

    notifyListeners();
  }

  removeItemInterval(List<KeyFrameItem> keyFrameItem) {
    keyFrameItem.forEach((element) {
      this.intervaltemList.remove(element);
    });

    notifyListeners();
  }

  addItemIso(KeyFrameItem keyFrameItem) {
    this.isoItemList.add(keyFrameItem);

    notifyListeners();
  }

  addItemShutter(KeyFrameItem keyFrameItem) {
    this.shutterItemList.add(keyFrameItem);
    notifyListeners();
  }

  addItemFstop(KeyFrameItem keyFrameItem) {
    this.fstoptemList.add(keyFrameItem);
    notifyListeners();
  }

  addItemInterval(KeyFrameItem keyFrameItem) {
    this.intervaltemList.add(keyFrameItem);
    notifyListeners();
  }

  removeItemIso(List<KeyFrameItem> keyFrameItem) {
    keyFrameItem.forEach((element) {
      this.isoItemList.remove(element);
    });

    notifyListeners();
  }

  updateItemIso(KeyFrameItem keyFrameItem, int index) {
    isoItemList[isoItemList.indexWhere(
        (element) => element.keyFrameINdex == index)] = keyFrameItem;
  }

  updateItemShutter(KeyFrameItem keyFrameItem, int index) {
    shutterItemList[shutterItemList.indexWhere(
        (element) => element.keyFrameINdex == index)] = keyFrameItem;
  }

  updateItemFstop(KeyFrameItem keyFrameItem, int index) {
    fstoptemList[fstoptemList.indexWhere(
        (element) => element.keyFrameINdex == index)] = keyFrameItem;
  }

  updateItemInterval(KeyFrameItem keyFrameItem, int index) {
    intervaltemList[intervaltemList.indexWhere(
        (element) => element.keyFrameINdex == index)] = keyFrameItem;
  }
}
