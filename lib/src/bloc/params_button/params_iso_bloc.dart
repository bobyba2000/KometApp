import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsIsoBloc extends Bloc<String, String> {
  ParamsIsoBloc() : super("--");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
