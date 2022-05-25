import 'package:equatable/equatable.dart';

class BulbTypeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BulbTypeEventTap extends BulbTypeEvent {}

class BulbTypeEventShot extends BulbTypeEvent {}

class BulbTypeEventHold extends BulbTypeEvent {}
