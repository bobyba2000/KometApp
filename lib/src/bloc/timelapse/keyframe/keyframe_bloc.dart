import 'package:flutter_bloc/flutter_bloc.dart';

class KeyFrameBloc extends Bloc<bool, bool> {
  KeyFrameBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
