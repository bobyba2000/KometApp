import 'package:flutter/material.dart';

import 'frame_play_fps_bloc.dart';

class NeoBlocProvider extends InheritedWidget {
  final FramePlayFpsBloc bloc;

  NeoBlocProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static FramePlayFpsBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<NeoBlocProvider>()
              as NeoBlocProvider)
          .bloc;
}
