import 'package:flutter_bloc/flutter_bloc.dart';

class SecondsRecieverBloc extends Bloc<int, int> {
  SecondsRecieverBloc() : super(60);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
