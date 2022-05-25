import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/pages/page_event.dart';
import 'package:neo/src/bloc/pages/page_state.dart';

class PagesBloc extends Bloc<PageEvent, PageState> {
  PagesBloc() : super(PageStateHomePage());

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is PageEventHome) {
      yield PageStateHomePage();
    }
    if (event is PageEventLandingPage) {
      yield PageStateLandingPage();
    }
    if (event is PageEventSettings) {
      yield PageStateSettingsPage();
    }
  }
}
