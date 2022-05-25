import 'package:neo/src/model/parent_model.dart';

/// RSP : {"FSTOP":{"CHOICE":["f/4","f/4.5","f/5","f/5.6","f/6.3","f/7.1","f/8","f/9","f/10","f/11","f/13","f/14","f/16","f/18","f/20","f/22"],"CURRENT":"f/5.6"}}

class FSTOPRESPONSE extends ParentModel {
  RSP rsp;

  FSTOPRESPONSE({this.rsp});

  FSTOPRESPONSE.fromJson(dynamic json) {
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
  String get current => rsp.fstop.current;

  @override
  List<String> get list => rsp.fstop.choice;
}

/// FSTOP : {"CHOICE":["f/4","f/4.5","f/5","f/5.6","f/6.3","f/7.1","f/8","f/9","f/10","f/11","f/13","f/14","f/16","f/18","f/20","f/22"],"CURRENT":"f/5.6"}

class RSP {
  FSTOP fstop;

  RSP({this.fstop});

  RSP.fromJson(dynamic json) {
    fstop = json["CONTROL_FSTOP"] != null
        ? FSTOP.fromJson(json["CONTROL_FSTOP"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (fstop != null) {
      map["CONTROL_FSTOP"] = fstop.toJson();
    }
    return map;
  }
}

/// CHOICE : ["f/4","f/4.5","f/5","f/5.6","f/6.3","f/7.1","f/8","f/9","f/10","f/11","f/13","f/14","f/16","f/18","f/20","f/22"]
/// CURRENT : "f/5.6"

class FSTOP {
  List<String> choice;
  String current;

  FSTOP({this.choice, this.current});

  FSTOP.fromJson(dynamic json) {
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
