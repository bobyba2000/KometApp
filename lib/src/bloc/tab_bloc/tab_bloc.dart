import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:neo/src/bloc/tab_bloc/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabStateInitial());

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is TabEventSwitchFstop) {
      yield TabStateFstop();
    }

    if (event is TabEventSwitchShutterSpeed) {
      yield TabStateShutterSpeed();
    }

    if (event is TabEventSwitchISO) {
      yield TabStateISO();
    }

    if (event is TabEventSwitchInitial) {
      yield TabStateInitial();
    }

    if (event is TabEventSwitchWB) {
      yield TabStateWB();
    }
    if (event is TabEventSwitchHDR) {
      yield TabStateHDR();
    }
    if (event is TabEventSwitchHolyISO) {
      yield TabStateHolyISO();
    }

    if (event is TabEventSwitchHolyShutterSp) {
      yield TabStateHolyShutterSp();
    }
    if (event is TabEventSwitchHolyFstop) {
      yield TabStateHolyFstop();
    }
    if (event is TabEventSwitchHolyInterval) {
      yield TabStateHolyInterval();
    }

    if (event is TabEventSwitchHolyDuration) {
      yield TabStateHolyDuration();
    }
    if (event is TabEventSwitchAddKeyFrame) {
      yield TabStateAddKeyFrame();
    }

    if (event is TabEventSwitcBasicInterval) {
      yield TabStateBasicInterval();
    }

    if (event is TabEventFlashSettings) {
      yield TabStateFlashSettings();
    }
  }
}
