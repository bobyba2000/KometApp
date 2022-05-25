import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_min_sec/bulb_min_sec_event.dart';
import 'package:neo/src/bloc/more_option/bulb_min_sec/bulb_min_sec_state.dart';

class BulbMinSecBloc extends Bloc<BulbMinSecEvent, BulbMinSecState> {
  BulbMinSecBloc() : super(BulbMinSecStateMinute());

  @override
  Stream<BulbMinSecState> mapEventToState(BulbMinSecEvent event) async* {
    if (event is BulbMinSecEventMinute) {
      yield BulbMinSecStateMinute();
    }
    if (event is BulbMinSecEventSeconds) {
      yield BulbMinSecStateSeconds();
    }
  }
}
