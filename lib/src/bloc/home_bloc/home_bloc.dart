import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_event.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateCamera());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventCamera) {
      yield HomeStateCamera();
    }

    if (event is HomeEventTimeLapse) {
      yield HomeStateTimelapse();
    }

    if (event is HomeEventFlash) {
      yield HomeStateFlash();
    }

    if (event is HomeEventFile) {
      yield HomeStateFile();
    }

    if (event is HomeEventHighSpeed) {
      yield HomeStateHighSpeed();
    }
  }
}
