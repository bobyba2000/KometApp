import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';

class FinalShutterSpBloc extends Bloc<HSelectedItem, HSelectedItem> {
  FinalShutterSpBloc() : super(HSelectedItem(value: "--", index: 1));

  @override
  Stream<HSelectedItem> mapEventToState(HSelectedItem event) async* {
    yield event;
  }
}
