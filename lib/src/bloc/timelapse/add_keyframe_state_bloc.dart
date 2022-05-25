import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddKeyFrameStateBloc extends Bloc<bool, bool> {
  AddKeyFrameStateBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
