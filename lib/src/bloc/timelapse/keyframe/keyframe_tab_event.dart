import 'package:equatable/equatable.dart';

class KeyFrameTabEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KeyFrameTabEventShutter extends KeyFrameTabEvent {}

class KeyFrameTabEventFstop extends KeyFrameTabEvent {}

class KeyFrameTabEventIso extends KeyFrameTabEvent {}

class KeyFrameTabEventInterval extends KeyFrameTabEvent {}

class KeyFrameTabEventInitial extends KeyFrameTabEvent {}
