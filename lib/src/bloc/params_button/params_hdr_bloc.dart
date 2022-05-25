import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsHdrBloc extends Bloc<String, String> {
  ParamsHdrBloc() : super("3 ±0.3");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
