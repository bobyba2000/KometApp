import 'package:equatable/equatable.dart';

class DurationFramePlayState extends Equatable {
  final String displayName;

  DurationFramePlayState(this.displayName);

  @override
  List<Object> get props => [];
}

class StateDuration extends DurationFramePlayState {
  StateDuration() : super("DURATION");
}

class StateFrame extends DurationFramePlayState {
  StateFrame() : super("FRAME");
}

class StatePlay extends DurationFramePlayState {
  StatePlay() : super("PLAY TIME");
}
