import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/ui/timelapse/tabs/holy_grail_duration/duration_state.dart';

class DurFramePlayBloc extends Bloc<int, DurationFramePlayState> {
  DurFramePlayBloc() : super(StateDuration());

  @override
  Stream<DurationFramePlayState> mapEventToState(int event) async* {
    if (event == 1) {
      yield StateDuration();
    }
    if (event == 2) {
      yield StateFrame();
    }
    if (event == 3) {
      yield StatePlay();
    }
  }
}
