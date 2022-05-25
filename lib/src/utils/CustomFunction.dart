import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:neo/src/model/ImageJSONModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFunction {
//WATER FALL
  Future<ImageJSONModel> jsonLoader({int indexValue, String type}) async {
    String data;
    if (type == 'W') {
      data = null;
      //Water Fall
      switch (indexValue) {
        case 1:
          data = await rootBundle.loadString('assets/json/waterfall1.json');
          break;

        case 2:
          data = await rootBundle.loadString('assets/json/waterfall2.json');
          break;

        case 3:
          data = await rootBundle.loadString('assets/json/waterfall3.json');
          break;

        case 4:
          data = await rootBundle.loadString('assets/json/waterfall4.json');
          break;

        case 5:
          data = await rootBundle.loadString('assets/json/waterfall5.json');
          break;
      }
    } else if (type == 'L') {
      data = null;
      // - assets/json/seascape_1.json
      // - assets/json/seascape_2.json
      // - assets/json/seascape_3.json
      // - assets/json/seascape_4.json
      // - assets/json/seascape_5.json

      switch (indexValue) {
        case 1:
          data =
              await rootBundle.loadString('assets/json/its-landscape_A.json');
          break;

        case 2:
          data =
              await rootBundle.loadString('assets/json/its-landscape_B.json');
          break;

        case 3:
          data =
              await rootBundle.loadString('assets/json/its-landscape_C.json');
          break;

        case 4:
          data =
              await rootBundle.loadString('assets/json/its-landscape_D.json');
          break;

        case 5:
          data =
              await rootBundle.loadString('assets/json/its-landscape_E.json');
          break;
      }
    } else if (type == 'S') {
      data = null;
      switch (indexValue) {
        case 1:
          data = await rootBundle.loadString('assets/json/seascape_1.json');
          break;

        case 2:
          data = await rootBundle.loadString('assets/json/seascape_2.json');
          break;

        case 3:
          data = await rootBundle.loadString('assets/json/seascape_3.json');
          break;

        case 4:
          data = await rootBundle.loadString('assets/json/seascape_4.json');
          break;

        case 5:
          data = await rootBundle.loadString('assets/json/seascape_5.json');
          break;
      }
    }

    var jsonResult = json.decode(data);
    ImageJSONModel imageJSONModel = ImageJSONModel.fromJson(jsonResult);
    return imageJSONModel;
  }

  void launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
