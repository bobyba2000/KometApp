import 'package:neo/src/model/parent_model.dart';

/// RSP : {"ISO":{"CHOICE":["Auto","L","100","125","160","200","250","320","400","500","640","800","1000","1250","1600","2000","2500","3200","4000","5000","6400","8000","10000","12800","16000","20000","25600","H1","H2"],"CURRENT":"1600"}}

class ISORESPONSE extends ParentModel {
  RSP rsp;

  ISORESPONSE({this.rsp});

  ISORESPONSE.fromJson(dynamic json) {
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
  String get current => rsp.iso.current;

  @override
  List<String> get list => rsp.iso.choice;
}

/// ISO : {"CHOICE":["Auto","L","100","125","160","200","250","320","400","500","640","800","1000","1250","1600","2000","2500","3200","4000","5000","6400","8000","10000","12800","16000","20000","25600","H1","H2"],"CURRENT":"1600"}

class RSP {
  ISO iso;

  RSP({this.iso});

  RSP.fromJson(dynamic json) {
    iso =
        json["CONTROL_ISO"] != null ? ISO.fromJson(json["CONTROL_ISO"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (iso != null) {
      map["CONTROL_ISO"] = iso.toJson();
    }
    return map;
  }
}

/// CHOICE : ["Auto","L","100","125","160","200","250","320","400","500","640","800","1000","1250","1600","2000","2500","3200","4000","5000","6400","8000","10000","12800","16000","20000","25600","H1","H2"]
/// CURRENT : "1600"

class ISO {
  List<String> choice;
  String current;

  ISO({this.choice, this.current});

  ISO.fromJson(dynamic json) {
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
