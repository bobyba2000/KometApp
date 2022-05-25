import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_state.dart';

import 'hdr_sequence_event.dart';

class HdrSequenceBloc extends Bloc<HdrSequenceEvent, HdrSequenceState> {
  HdrSequenceBloc() : super(HdrSequenceStateInitial());

  @override
  Stream<HdrSequenceState> mapEventToState(event) async* {
    if (event is HdrSequenceEventSwitchInitial) {
      yield HdrSequenceStateInitial();
    }
    if (event is HdrSequenceEventSwitchIso) {
      yield HdrSequenceStateIso();
    }

    if (event is HdrSequenceEventSwitchFstop) {
      yield HdrSequenceStateFstop();
    }

    if (event is HdrSequenceEventSwitchShutterSpeed) {
      yield HdrSequenceStateShutter();
    }
  }
}
