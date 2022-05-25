import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';

class InitialShutterSpBloc extends Bloc<HSelectedItem, HSelectedItem> {
  InitialShutterSpBloc() : super(HSelectedItem(value: "--", index: 1));

  @override
  Stream<HSelectedItem> mapEventToState(HSelectedItem event) async* {
    yield event;
  }
}
