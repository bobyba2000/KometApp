import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsShutterBloc extends Bloc<String, String> {
  ParamsShutterBloc() : super("--");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
