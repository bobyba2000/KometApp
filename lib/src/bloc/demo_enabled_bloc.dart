import 'package:flutter_bloc/flutter_bloc.dart';

class DemoEnabledBloc extends Bloc<bool, bool> {
  DemoEnabledBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }

  switchDemo() {
    add(!state);
  }
}
