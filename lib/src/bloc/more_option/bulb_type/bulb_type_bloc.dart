import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_event.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_state.dart';

class BulbTypeBloc extends Bloc<BulbTypeEvent, BulbTypeState> {
  BulbTypeBloc() : super(BulbTypeStateShot());

  @override
  Stream<BulbTypeState> mapEventToState(BulbTypeEvent event) async* {
    if (event is BulbTypeEventShot) {
      yield BulbTypeStateShot();
    }
    if (event is BulbTypeEventTap) {
      yield BulbTypeStateTap();
    }

    if (event is BulbTypeEventHold) {
      yield BulbTypeStateHold();
    }
  }
}
