import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShutLagMotCotBloc extends Bloc<ShutLagMotCotEvent, ShutLagMotCotState> {
  /// This Bloc Controlls the state of Motion Control and
  ///  Shutter Lag  options in
  ///  More Option when is Holy Grail
  ShutLagMotCotBloc() : super(ShutLagState());

  @override
  Stream<ShutLagMotCotState> mapEventToState(ShutLagMotCotEvent event) async* {
    if (event is ShutLagEvent) {
      yield ShutLagState();
    }

    if (event is MotCotEvent) {
      yield MotCotState();
    }
  }
}

//STATE

class ShutLagMotCotState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShutLagState extends ShutLagMotCotState {}

class MotCotState extends ShutLagMotCotState {}

//EVENT

class ShutLagMotCotEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ShutLagEvent extends ShutLagMotCotEvent {}

class MotCotEvent extends ShutLagMotCotEvent {}
