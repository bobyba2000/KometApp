import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchDistanceBloc extends Bloc<bool, bool> {
  SwitchDistanceBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }

  switchDistance() {
    add(!state);
  }
}
