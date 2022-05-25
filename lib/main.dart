import 'package:flutter/material.dart';
import 'package:neo/src/app.dart';
import 'package:neo/src/model/edit_key_frame_model.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:provider/provider.dart';
import 'src/model/capture_button_model.dart';
import 'src/model/keyframe/keyframe_shutter_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = SimpleBlocObserver();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UrlHolder()),
      ChangeNotifierProvider.value(value: CaptureButtonModel()),
      ChangeNotifierProvider.value(value: KeyFrameModel()),
      ChangeNotifierProvider.value(value: EditKeyFrameModel())
    ],
    child: App(),
  ));
}
