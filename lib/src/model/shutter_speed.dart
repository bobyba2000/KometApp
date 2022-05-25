import 'package:neo/src/model/parent_model.dart';

/// SHUTTERSPEED : {"CHOICE":["30","25","20","15","13","10.3","8","6.3","5","4","3.2","2.5","2","1.6","1.3","1","0.8","0.6","0.5","0.4","0.3","1/4","1/5","1/6","1/8","1/10","1/13","1/15","1/20","1/25","1/30","1/40","1/50","1/60","1/80","1/100","1/125","1/160","1/200","1/250","1/320","1/400","1/500","1/640","1/800","1/1000","1/1250","1/1600","1/2000","1/2500","1/3200","1/4000"],"CURRENT":"1/15"}

class ShutterSpeed extends ParentModel {
  SHUTTERSPEED shutterspeed;

  ShutterSpeed({this.shutterspeed});

  ShutterSpeed.fromJson(dynamic json) {
    shutterspeed = json["RSP"]["CONTROL_SHUTTERSPEED"] != null
        ? SHUTTERSPEED.fromJson(json["RSP"]["CONTROL_SHUTTERSPEED"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (shutterspeed != null) {
      map["CONTROL_SHUTTERSPEED"] = shutterspeed.toJson();
    }
    return map;
  }

  @override
  String get current => shutterspeed.current;

  @override
  List<String> get list => shutterspeed.choice;
}

/// CHOICE : ["30","25","20","15","13","10.3","8","6.3","5","4","3.2","2.5","2","1.6","1.3","1","0.8","0.6","0.5","0.4","0.3","1/4","1/5","1/6","1/8","1/10","1/13","1/15","1/20","1/25","1/30","1/40","1/50","1/60","1/80","1/100","1/125","1/160","1/200","1/250","1/320","1/400","1/500","1/640","1/800","1/1000","1/1250","1/1600","1/2000","1/2500","1/3200","1/4000"]
/// CURRENT : "1/15"

class SHUTTERSPEED {
  List<String> choice;
  String current;

  SHUTTERSPEED({this.choice, this.current});

  SHUTTERSPEED.fromJson(dynamic json) {
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
