import 'package:equatable/equatable.dart';

class StepBracketValuesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EventIncrementStep extends StepBracketValuesEvent {}

class EventDecrementStep extends StepBracketValuesEvent {}
