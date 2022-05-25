import 'package:flutter_bloc/flutter_bloc.dart';

class LockMainScrollBloc extends Bloc<bool, bool> {
  LockMainScrollBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
