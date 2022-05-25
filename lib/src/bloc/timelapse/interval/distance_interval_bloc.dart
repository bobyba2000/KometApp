import 'package:flutter_bloc/flutter_bloc.dart';

class DistanceIntervalBloc extends Bloc<int, int> {
  DistanceIntervalBloc() : super(0);

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
