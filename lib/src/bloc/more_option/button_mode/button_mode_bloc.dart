import 'package:bloc/bloc.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_event.dart';
import 'package:neo/src/bloc/more_option/button_mode/button_mode_state.dart';

class ButtonModeBloc extends Bloc<ButtonModeEvent, ButtonModeState> {
  ButtonModeBloc() : super(ButtonModeStateManual());

  @override
  Stream<ButtonModeState> mapEventToState(ButtonModeEvent event) async* {
    if (event is ButtonModeEventManual) {
      yield ButtonModeStateManual();
    }
    if (event is ButtonModeEventBulb) {
      yield ButtonModeStateBulb();
    }
  }
}
