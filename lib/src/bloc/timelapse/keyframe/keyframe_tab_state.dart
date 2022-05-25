import 'package:equatable/equatable.dart';

class KeyFrameState extends Equatable {
  @override
  List<Object> get props => [];
}

class KeyFrameTabState extends KeyFrameState {}

class KeyFrameTabStateInitial extends KeyFrameState {}

class KeyFrameTabStateShutter extends KeyFrameTabState {}

class KeyFrameTabStateFstop extends KeyFrameTabState {}

class KeyFrameTabStateIso extends KeyFrameTabState {}

class KeyFrameTabStateInterval extends KeyFrameTabState {}
