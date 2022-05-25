import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';

class HighLightedKeyFrameBloc
    extends Bloc<List<KeyFrameItem>, List<KeyFrameItem>> {
  HighLightedKeyFrameBloc() : super([]);

  @override
  Stream<List<KeyFrameItem>> mapEventToState(List<KeyFrameItem> event) async* {
    yield [];
    yield event;
  }

  addItem(KeyFrameItem index) {
    state.add(index);
    add(state);
  }

  removeItem(KeyFrameItem items) {
    state.remove(items);
    add(state);
  }

  removeAll() {
    state.clear();
    add(state);
  }
}
