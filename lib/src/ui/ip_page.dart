import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/flickr/flickr_state_bloc.dart';
import 'package:neo/src/bloc/pages/page_state.dart';
import 'package:neo/src/bloc/pages/pages_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/model/url_holder.dart';
import 'package:neo/src/ui/settings_page.dart';
import 'package:provider/provider.dart';

import 'camera_photo_shutterspeed.dart';
import 'home/home_page.dart';

class IpPage extends StatefulWidget {
  @override
  _IpPageState createState() => _IpPageState();
}

class _IpPageState extends State<IpPage> {
  @override
  void initState() {
    context.read<FlickrStateBloc>().add(InitFlickrStateEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#0E1011"),
      body: Consumer<UrlHolder>(
        builder: (context, value, child) {
          return BlocBuilder<PagesBloc, PageState>(
            builder: (context, state) {
              if (state is PageStateLandingPage) {
                return CameraPhotoShutterSpeed();
              }
              if (state is PageStateHomePage) {
                return HomePage();
              }
              if (state is PageStateSettingsPage) {
                return SettingsPage();
              }

              return CameraPhotoShutterSpeed();
            },
          );
        },
      ),
    );
  }
}
