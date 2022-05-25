import 'package:meta/meta.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';

class HolyGraphListModel {
  String iconEnabled;
  String iconDisabled;
  DateTime dateTime;
  KeyFrameItem keyFrameItem;
  String curveType;
  HolyGraphListModel({
    @required this.iconEnabled,
    @required this.iconDisabled,
    @required this.dateTime,
    @required this.keyFrameItem,
    @required this.curveType,
  });
}
