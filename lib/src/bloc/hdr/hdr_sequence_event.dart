import 'package:equatable/equatable.dart';

class HdrSequenceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HdrSequenceEventSwitchInitial extends HdrSequenceEvent {}

class HdrSequenceEventSwitchIso extends HdrSequenceEvent {}

class HdrSequenceEventSwitchFstop extends HdrSequenceEvent {}

class HdrSequenceEventSwitchShutterSpeed extends HdrSequenceEvent {}
