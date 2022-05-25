import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';

import 'keyframe_tab_event.dart';

class KeyFrameTabBloc extends Bloc<KeyFrameTabEvent, KeyFrameState> {
  KeyFrameTabBloc() : super(KeyFrameTabStateInitial());

  @override
  Stream<KeyFrameState> mapEventToState(KeyFrameTabEvent event) async* {
    if (event is KeyFrameTabEventShutter) {
      yield KeyFrameTabStateShutter();
    }
    if (event is KeyFrameTabEventFstop) {
      yield KeyFrameTabStateFstop();
    }
    if (event is KeyFrameTabEventIso) {
      yield KeyFrameTabStateIso();
    }
    if (event is KeyFrameTabEventInterval) {
      yield KeyFrameTabStateInterval();
    }

    if (event is KeyFrameTabEventInitial) {
      yield KeyFrameTabStateInitial();
    }
  }
}
