import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';

class FrameKeyIndex extends Bloc<HSelectedItem, HSelectedItem> {
  FrameKeyIndex() : super(HSelectedItem(index: null, value: null));

  @override
  Stream<HSelectedItem> mapEventToState(HSelectedItem event) async* {
    yield event;
  }
}
