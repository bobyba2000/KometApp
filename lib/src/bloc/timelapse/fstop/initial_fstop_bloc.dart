import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';

class InitialFstopBloc extends Bloc<HSelectedItem, HSelectedItem> {
  InitialFstopBloc() : super(HSelectedItem(value: "--", index: 2));

  @override
  Stream<HSelectedItem> mapEventToState(HSelectedItem event) async* {
    yield event;
  }
}
