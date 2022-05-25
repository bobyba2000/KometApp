import 'package:flutter_bloc/flutter_bloc.dart';

class ApertureRampBloc extends Bloc<bool, bool> {
  ApertureRampBloc() : super(true);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
