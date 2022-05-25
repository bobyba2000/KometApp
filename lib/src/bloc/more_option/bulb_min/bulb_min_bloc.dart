import 'package:flutter_bloc/flutter_bloc.dart';

class BulbMinBloc extends Bloc<int, int> {
  BulbMinBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    if (event <= 59) {
      if (event < 0) {
        yield 0;
      } else {
        yield event;
      }
    } else {
      yield 59;
    }
  }
}

class BulbSecBloc extends Bloc<int, int> {
  BulbSecBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    if (event <= 59) {
      if (event < 0) {
        yield 0;
      } else {
        yield event;
      }
    } else {
      yield 59;
    }
  }
}
