import 'package:flutter_bloc/flutter_bloc.dart';

class LiveViewBloc extends Bloc<bool, bool> {
  LiveViewBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
