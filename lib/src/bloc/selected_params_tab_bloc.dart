import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedParamsTabBloc extends Bloc<int, int> {
  SelectedParamsTabBloc() : super(null);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
