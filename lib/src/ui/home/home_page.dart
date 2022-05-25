import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/home_bloc/home_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_event.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';
import 'package:neo/src/bloc/pages/page_event.dart';
import 'package:neo/src/bloc/pages/pages_bloc.dart';
import 'package:neo/src/bloc/scroll/lock_main_scroll_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_bloc.dart';
import 'package:neo/src/bloc/tab_bloc/tab_event.dart';
import 'package:neo/src/bloc/timelapse/basic_holy_grail_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> list = [
    Items(
        icon: "assets/icons/Icon_Camera.svg",
        title: "CAMERA",
        subTitle: "Photo and Video Control",
        state: HomeStateCamera()),
    Items(
        icon: "assets/icons/Icon_Timelapse.svg",
        title: "TIMELAPSE",
        subTitle: "Basic and Holy-Grail Timelapse",
        state: HomeStateTimelapse()),
    Items(
        icon: "assets/icons/Icon_HighSpeed.svg",
        title: "HIGH-SPEED",
        subTitle: "Light, Sound and Laser Trigger",
        state: HomeStateHighSpeed()),
    Items(
        icon: "assets/icons/Icon_Flash.svg",
        title: "FLASH",
        subTitle: "Speedlight Trigger",
        state: HomeStateFlash()),
    Items(
        icon: "assets/icons/Icon_File.svg",
        title: "FILE",
        subTitle: "File Management and Backup",
        state: HomeStateFile())
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print("state $state");
        return Scaffold(
          backgroundColor: HexColor.fromHex("#030303"),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 96.h,
                      ),
                      for (var item in list)
                        HomeItem(
                          // selected: item.state == state,
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 800));
                            context
                                .read<HomeBloc>()
                                .add(returnEvent(item.state));

                            context
                                .read<PagesBloc>()
                                .add(PageEventLandingPage());
                            context
                                .read<TabBloc>()
                                .add(TabEventSwitchInitial());
                            if (item.state is! HomeStateTimelapse) {
                              context.read<KeyFrameBloc>().add(false);
                              context.read<LockMainScrollBloc>().add(false);
                              context.read<BasicHolyGrailBloc>().add(0);
                            } else {
                              context.read<LockMainScrollBloc>().add(true);
                            }
                          },
                          icon: item.icon,
                          title: item.title,
                          subtitle: item.subTitle,
                        ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 15.h,
                            width: 15.h,
                            decoration: BoxDecoration(
                                color: HexColor.fromHex("#00FF00"),
                                borderRadius: BorderRadius.circular(15.h)),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            "CONNECTED",
                            style: latoSemiBold.copyWith(
                                color: HexColor.fromHex("#EDEFF0"),
                                fontSize: 12.sp),
                          ),
                        ],
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: HexColor.fromHex("#0E1011"),
                          padding: EdgeInsets.symmetric(horizontal: 36.w),
                          height: 84.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BottomBtn(
                                onTap: () {
                                  context
                                      .read<PagesBloc>()
                                      .add(PageEventSettings());
                                },
                                inactiveIcon:
                                    "assets/icons/Button_Settings_Idle.svg",
                                activeIcon:
                                    "assets/icons/Button_Settings_Pressed.svg",
                              ),
                              BottomBtn(
                                inactiveIcon:
                                    "assets/icons/Button_Preset_Idle.svg",
                                activeIcon:
                                    "assets/icons/Button_Preset_Pressed.svg",
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  HomeEvent returnEvent(HomeState state) {
    if (state is HomeStateCamera) {
      return HomeEventCamera();
    }
    if (state is HomeStateTimelapse) {
      return HomeEventTimeLapse();
    }
    if (state is HomeStateHighSpeed) {
      return HomeEventHighSpeed();
    }
    if (state is HomeStateFile) {
      return HomeEventFile();
    }
    if (state is HomeStateFlash) {
      return HomeEventFlash();
    }
    return HomeEventCamera();
  }
}

class BottomBtn extends StatefulWidget {
  final String activeIcon;
  final String inactiveIcon;

  GestureTapCallback onTap;

  BottomBtn(
      {Key key,
      @required this.activeIcon,
      @required this.inactiveIcon,
      this.onTap})
      : super(key: key);

  @override
  _BottomBtnState createState() => _BottomBtnState();
}

class _BottomBtnState extends State<BottomBtn> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          tapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          tapped = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(0),
        child: SvgPicture.asset(
          tapped ? widget.activeIcon : widget.inactiveIcon,
          height: 36.h,
          color: Colors.white,
          width: 36.w,
        ),
      ),
    );
  }
}

class HomeItem extends StatefulWidget {
  final String icon;
  final String title;
  final String subtitle;
  // final bool selected;
  final Function() onTap;

  const HomeItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.subtitle,
      // this.selected = false,
      this.onTap})
      : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          tapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          tapped = false;
        });
      },
      child: Container(
          height: 76.h,
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 27.w),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.sp,
                color:
                    tapped ? HexColor.neoBlue() : HexColor.fromHex("#1D1D1F"),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                widget.icon,
                height: 50.h,
                width: 60.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.title}",
                    style: latoBold.copyWith(
                        color: tapped
                            ? HexColor.fromHex("#EDEFF0")
                            : HexColor.fromHex("#959FA5"),
                        fontSize: 20.sp),
                  ),
                  Text(
                    "${widget.subtitle}",
                    style: latoSemiBold.copyWith(
                        color: tapped
                            ? HexColor.fromHex("#959FA5")
                            : HexColor.fromHex("#3E505B"),
                        fontSize: 12.sp),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: HexColor.neoBlue(),
                ),
                onPressed: () {},
              )
            ],
          )),
    );
  }
}

class Items {
  String title;
  String subTitle;
  String icon;
  HomeState state;
  Items(
      {@required this.title,
      @required this.subTitle,
      @required this.icon,
      @required this.state});
}
