import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class BulbTapBloc extends Bloc<bool, bool> {
  BulbTapBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
