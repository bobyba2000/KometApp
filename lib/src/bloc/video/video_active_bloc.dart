import 'package:bloc/bloc.dart';

class VideoActiveBloc extends Bloc<bool, bool> {
  VideoActiveBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
