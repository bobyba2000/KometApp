import 'package:flutter_bloc/flutter_bloc.dart';

class BulbTimeCounterBloc extends Bloc<String, String> {
  BulbTimeCounterBloc() : super("00 : 00 : 00");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
