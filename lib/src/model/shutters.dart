import 'package:meta/meta.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_state.dart';

class Shutters {
  String name;
  double heigh;
  bool showName;
  int index;
  Shutters(
      {@required this.name,
      @required this.heigh,
      @required this.showName,
      @required this.index});
}

class Sequence {
  double name;
  double heigh;
  double width;

  bool showName;
  bool isMin;
  bool isMax;

  HdrSequenceState state;

  Sequence({
    @required this.name,
    @required this.heigh,
    @required this.showName,
    @required this.width,
    @required this.isMin,
    @required this.isMax,
    @required this.state,
  });

  String get getColor {
    if (state is HdrSequenceStateCenter) {
      return "#3498DB";
    }

    if (state is HdrSequenceStateShutter) {
      return "#DC143C";
    }
    if (state is HdrSequenceStateIso) {
      return "#00FFFF";
    }
    if (state is HdrSequenceStateFstop) {
      return "#00FF00";
    }

    if (state is HdrSequenceStateCenterO) {
      return "#1D5378";
    }

    if (state is HdrSequenceStateShutterO) {
      return "#6E0A1E";
    }

    if (state is HdrSequenceStateIsoO) {
      return "#008080";
    }

    if (state is HdrSequenceStateFstopO) {
      return "#00b300";
    }

    return "#3E505B";
  }
}
