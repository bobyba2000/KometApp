import 'package:flutter_bloc/flutter_bloc.dart';

class BasicHolyGrailBloc extends Bloc<int, int> {
  BasicHolyGrailBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
