import 'package:flutter_bloc/flutter_bloc.dart';

class ShutterLagSecBloc extends Bloc<int, int> {
  ShutterLagSecBloc() : super(5);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }

  increment() {
    if (state < 59) {
      add(state + 1);
    }
  }

  decrement() {
    if (state > 0) {
      add(state - 1);
    }
  }
}
