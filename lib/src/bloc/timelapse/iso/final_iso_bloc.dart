import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';

class FinalIsoBloc extends Bloc<HSelectedItem, HSelectedItem> {
  FinalIsoBloc() : super(HSelectedItem(value: "--", index: 3));

  @override
  Stream<HSelectedItem> mapEventToState(HSelectedItem event) async* {
    yield event;
  }
}
