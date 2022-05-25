import 'package:equatable/equatable.dart';

class TabEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabEventSwitchShutterSpeed extends TabEvent {}

class TabEventSwitchISO extends TabEvent {}

class TabEventSwitchFstop extends TabEvent {}

class TabEventSwitchInitial extends TabEvent {}

class TabEventSwitchWB extends TabEvent {}

class TabEventSwitchHDR extends TabEvent {}

class TabEventSwitchHolyISO extends TabEvent {}

class TabEventSwitchHolyShutterSp extends TabEvent {}

class TabEventSwitchHolyFstop extends TabEvent {}

class TabEventSwitchHolyInterval extends TabEvent {}

class TabEventSwitchHolyDuration extends TabEvent {}

class TabEventSwitchAddKeyFrame extends TabEvent {}

class TabEventFlashSettings extends TabEvent {}

class TabEventSwitcBasicInterval extends TabEvent {}
