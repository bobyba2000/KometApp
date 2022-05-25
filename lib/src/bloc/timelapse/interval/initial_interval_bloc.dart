import 'package:bloc/bloc.dart';

class InitialIntervalBloc extends Bloc<String, String> {
  int sec = 4;
  InitialIntervalBloc() : super("--");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }

  increment() {
    if (sec < 3600) {
      sec++;
      add("${sec}s");
    }
  }

  decrement() {
    if (sec > 0) {
      sec--;
      add("${sec}s");
    }
  }
}
