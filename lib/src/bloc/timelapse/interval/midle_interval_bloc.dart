import 'package:bloc/bloc.dart';

class MidleIntervalBloc extends Bloc<int, int> {
  MidleIntervalBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }

  increment() {
    if (state < 3600) {
      add(state + 1);
    }
  }

  decrement() {
    if (state > 0) {
      add(state - 1);
    }
  }
}
