import 'package:neo/src/model/parent_model.dart';

/// RSP : {"WHITEBALANCE":{"CHOICE":["Auto","Daylight","Shadow","Cloudy","Tungsten","Fluorescent","Flash","",""],"CURRENT":"Daylight"}}

class WhiteBalance extends ParentModel {
  RSP rsp;

  WhiteBalance({this.rsp});

  WhiteBalance.fromJson(dynamic json) {
    rsp = json["RSP"] != null ? RSP.fromJson(json["RSP"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (rsp != null) {
      map["RSP"] = rsp.toJson();
    }
    return map;
  }

  @override
  String get current => rsp.whitebalance.current;

  @override
  List<String> get list => rsp.whitebalance.choice;
}

/// WHITEBALANCE : {"CHOICE":["Auto","Daylight","Shadow","Cloudy","Tungsten","Fluorescent","Flash","",""],"CURRENT":"Daylight"}

class RSP {
  WHITEBALANCE whitebalance;

  RSP({this.whitebalance});

  RSP.fromJson(dynamic json) {
    whitebalance = json["CONTROL_WHITEBALANCE"] != null
        ? WHITEBALANCE.fromJson(json["CONTROL_WHITEBALANCE"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (whitebalance != null) {
      map["CONTROL_WHITEBALANCE"] = whitebalance.toJson();
    }
    return map;
  }
}

/// CHOICE : ["Auto","Daylight","Shadow","Cloudy","Tungsten","Fluorescent","Flash","",""]
/// CURRENT : "Daylight"

class WHITEBALANCE {
  List<String> choice;
  String current;

  WHITEBALANCE({this.choice, this.current});

  WHITEBALANCE.fromJson(dynamic json) {
    choice = json["CHOICE"] != null ? json["CHOICE"].cast<String>() : [];
    current = json["CURRENT"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CHOICE"] = choice;
    map["CURRENT"] = current;
    return map;
  }
}
