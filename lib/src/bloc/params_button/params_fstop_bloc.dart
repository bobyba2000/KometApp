import 'package:flutter_bloc/flutter_bloc.dart';

class ParamsFstopBloc extends Bloc<String, String> {
  ParamsFstopBloc() : super("--");

  @override
  Stream<String> mapEventToState(String event) async* {
    yield event;
  }
}
