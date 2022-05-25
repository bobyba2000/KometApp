import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeEventCamera extends HomeEvent {}

class HomeEventTimeLapse extends HomeEvent {}

class HomeEventHighSpeed extends HomeEvent {}

class HomeEventFlash extends HomeEvent {}

class HomeEventFile extends HomeEvent {}
