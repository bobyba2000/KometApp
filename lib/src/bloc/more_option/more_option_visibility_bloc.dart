import 'package:bloc/bloc.dart';

class MoreOptionVisibilityBloc extends Bloc<bool, bool> {
  MoreOptionVisibilityBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
