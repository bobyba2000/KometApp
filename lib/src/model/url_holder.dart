import 'package:flutter/material.dart';
import 'package:neo/src/ui/settings_page.dart';

class UrlHolder extends ChangeNotifier {
  String url = SettingsPage.urlDemo;

  setUrl(String url) {
    this.url = url;
    notifyListeners();
  }
}
