import 'package:equatable/equatable.dart';

class CameraControllsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraControllsEventFetch extends CameraControllsEvent {}

class CameraControllsEventFetchShutterSpeed extends CameraControllsEvent {}

class CameraControllsEventFetchISO extends CameraControllsEvent {}

class CameraControllsEventFetchFstop extends CameraControllsEvent {}

class CameraControllsEventISOValueChanged extends CameraControllsEvent {
  final String value;

  CameraControllsEventISOValueChanged(this.value);
}

class CameraControllsEventSHUTTERSPEEDValueChanged
    extends CameraControllsEvent {
  final String value;

  CameraControllsEventSHUTTERSPEEDValueChanged(this.value);
}

class CameraControllsEventFSTOPValueChanged extends CameraControllsEvent {
  final String value;

  CameraControllsEventFSTOPValueChanged(this.value);
}

class CameraControllsEventReconnectServer extends CameraControllsEvent {}
