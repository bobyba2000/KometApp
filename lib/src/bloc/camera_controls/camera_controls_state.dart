import 'package:equatable/equatable.dart';

class CameraControlState extends Equatable {
  @override
  List<Object> get props => [];
}

class CameraControlStateInitial extends CameraControlState {}

class CameraControlStateLoading extends CameraControlState {}

class CameraControlStateSuccess extends CameraControlState {
  final List<String> list;
  final String currentItem;

  CameraControlStateSuccess(this.list, this.currentItem);
}

class CameraControlStateError extends CameraControlState {
  final String error;

  CameraControlStateError(this.error);
}
