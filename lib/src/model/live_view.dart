/// RSP : {"LIVEVIEW":"OK","STREAM":"http://10.10.10.253:8080/feed.mjpg"}

class LiveView {
  RSP rsp;

  LiveView({
      this.rsp});

  LiveView.fromJson(dynamic json) {
    rsp = json["RSP"] != null ? RSP.fromJson(json["RSP"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (rsp != null) {
      map["RSP"] = rsp.toJson();
    }
    return map;
  }

}

/// LIVEVIEW : "OK"
/// STREAM : "http://10.10.10.253:8080/feed.mjpg"

class RSP {
  String liveview;
  String stream;

  RSP({
      this.liveview, 
      this.stream});

  RSP.fromJson(dynamic json) {
    liveview = json["LIVEVIEW"];
    stream = json["STREAM"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["LIVEVIEW"] = liveview;
    map["STREAM"] = stream;
    return map;
  }

}