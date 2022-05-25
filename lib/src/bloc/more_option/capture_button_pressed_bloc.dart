import 'package:flutter_bloc/flutter_bloc.dart';

class CaptureButtonPressedBloc extends Bloc<bool, bool> {
  CaptureButtonPressedBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
