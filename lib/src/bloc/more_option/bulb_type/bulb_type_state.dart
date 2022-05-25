import 'package:equatable/equatable.dart';

class BulbTypeState extends Equatable {
  final String name;

  BulbTypeState(this.name);
  @override
  List<Object> get props => [];
}

class BulbTypeStateTap extends BulbTypeState {
  BulbTypeStateTap() : super("Bulb Tap");
}

class BulbTypeStateShot extends BulbTypeState {
  BulbTypeStateShot() : super("Bulb Shot");
}

class BulbTypeStateHold extends BulbTypeState {
  BulbTypeStateHold() : super("Bulb Hold");
}
