import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/histo_model.dart';

class MjpegHistoBloc extends Bloc<MjPegHistoEvent, MjpegHistoState> {
  MjpegHistoBloc() : super(MjpegHistoStateInitial([], [], []));

  @override
  Stream<MjpegHistoState> mapEventToState(MjPegHistoEvent event) async* {
    if (event is MjPegHistoEventAdd) {
      yield MjpegHistoStateInitial(event.redBin, event.greenBin, event.blueBin);
      yield MjpegHistoStateAdd(event.redBin, event.greenBin, event.blueBin);
    } else if (event is MjpegHistoErrorEvent) {
      yield MjpegHistoErrorState(
          event.redBin, event.greenBin, event.blueBin, event.errorMessage);
    }
  }
}

class MjPegHistoEvent extends Equatable {
  final List<HistoModel> redBin;
  final List<HistoModel> greenBin;
  final List<HistoModel> blueBin;

  MjPegHistoEvent(this.redBin, this.greenBin, this.blueBin);
  @override
  List<Object> get props => [];
}

class MjPegHistoEventAdd extends MjPegHistoEvent {
  MjPegHistoEventAdd(List<HistoModel> redBin, List<HistoModel> greenBin,
      List<HistoModel> blueBin)
      : super(redBin, greenBin, blueBin);
}

class MjpegHistoState extends Equatable {
  final List<HistoModel> redBin;
  final List<HistoModel> greenBin;
  final List<HistoModel> blueBin;

  MjpegHistoState(this.redBin, this.greenBin, this.blueBin);

  @override
  List<Object> get props => [redBin, greenBin, blueBin];
}

class MjpegHistoStateInitial extends MjpegHistoState {
  MjpegHistoStateInitial(List<HistoModel> redBin, List<HistoModel> greenBin,
      List<HistoModel> blueBin)
      : super(redBin, greenBin, blueBin);
}

class MjpegHistoStateAdd extends MjpegHistoState {
  MjpegHistoStateAdd(List<HistoModel> redBin, List<HistoModel> greenBin,
      List<HistoModel> blueBin)
      : super(redBin, greenBin, blueBin);
}

class MjpegHistoErrorState extends MjpegHistoState {
  final String errorMessage;
  MjpegHistoErrorState(List<HistoModel> redBin, List<HistoModel> greenBin,
      List<HistoModel> blueBin, this.errorMessage)
      : super(redBin, greenBin, blueBin);
}

class MjpegHistoErrorEvent extends MjPegHistoEvent {
  final String errorMessage;
  MjpegHistoErrorEvent(List<HistoModel> redBin, List<HistoModel> greenBin,
      List<HistoModel> blueBin, this.errorMessage)
      : super(redBin, greenBin, blueBin);
}
