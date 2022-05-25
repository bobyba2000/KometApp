class ImageJSONModel {
  String owner;
  String title;
  EXIF eXIF;
  String uRL;

  ImageJSONModel({this.owner, this.title, this.eXIF, this.uRL});

  ImageJSONModel.fromJson(Map<String, dynamic> json) {
    owner = json['Owner'];
    title = json['Title'];
    eXIF = json['EXIF'] != null ? new EXIF.fromJson(json['EXIF']) : null;
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Owner'] = this.owner;
    data['Title'] = this.title;
    if (this.eXIF != null) {
      data['EXIF'] = this.eXIF.toJson();
    }
    data['URL'] = this.uRL;
    return data;
  }
}

class EXIF {
  String cAMERA;
  String lENS;
  String sHUTTER;
  String fSTOP;
  String iSO;
  String zOOM;

  EXIF({this.cAMERA, this.lENS, this.sHUTTER, this.fSTOP, this.iSO, this.zOOM});

  EXIF.fromJson(Map<String, dynamic> json) {
    cAMERA = json['CAMERA'];
    lENS = json['LENS'];
    sHUTTER = json['SHUTTER'];
    fSTOP = json['FSTOP'];
    iSO = json['CONTROL_ISO'];
    zOOM = json['ZOOM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CAMERA'] = this.cAMERA;
    data['LENS'] = this.lENS;
    data['SHUTTER'] = this.sHUTTER;
    data['FSTOP'] = this.fSTOP;
    data['CONTROL_ISO'] = this.iSO;
    data['ZOOM'] = this.zOOM;
    return data;
  }
}
