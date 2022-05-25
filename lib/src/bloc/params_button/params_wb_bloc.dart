import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsWbBloc extends Bloc<String, String> {
  ParamsWbBloc() : super("--");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
