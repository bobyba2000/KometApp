import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/home_bloc/home_bloc.dart';
import 'package:neo/src/bloc/home_bloc/home_state.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

import 'camera_shutterspeed/home_menu_button.dart';

class CustomeAppBar extends PreferredSize {
  final Size size = Size.fromHeight(60);

  final Widget child;

  CustomeAppBar(this.child);

  @override
  Size get preferredSize => size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:  EdgeInsets.only(top: 30.h),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                HomeMenuButton(),
                SizedBox(
                  width: 15.h,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    String title;
                    switch (state.runtimeType) {
                      case HomeStateCamera:
                        title = "CAMERA";
                        break;
                      case HomeStateTimelapse:
                        title = "TIMELAPSE";
                        break;

                      case HomeStateFlash:
                        title = "FLASH";
                        break;

                      case HomeStateHighSpeed:
                        title = "HIGH-SPEED";
                        break;

                      case HomeStateFile:
                        title = "FILE";
                        break;
                      default:
                        title = "CAMERA";
                    }
                    return Text(
                      title,
                      style: latoSemiBold.copyWith(
                          fontSize: 20.sp, color: HexColor.fromHex("#EDEFF0")),
                    );
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  final bool isAction;

  final Size size = Size.fromHeight(30);
  CustomAppBar({Key key, this.isAction}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          HomeMenuButton(),
          SizedBox(
            width: 15.h,
          ),
          Text("CAMERA",
              style: latoSemiBold.copyWith(
                  fontSize: 20.sp, color: HexColor.fromHex("#EDEFF0"))
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: 30.h,
              //   ),
              //   child:,
              //   ),
              ),

          Container(
            height: 50.h,
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //
          //   ]),
          // ),
          // widget.isAction
          //     ? Align(
          //         alignment: Alignment.centerRight,
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 15.0),
          //           child: SvgPicture.asset(
          //             'assets/icons/Button_Add_Pressed.svg',
          //             height: 36.h,
          //             color: Colors.white,
          //             width: 36.w,
          //           ),
          //         ),
          //       )
          //     : SizedBox.shrink()
        ],
      ),
    );
  }
}

class BackCustomUI extends StatefulWidget {
  final Size size = Size.fromHeight(60);
  final Widget actionWidget;
  String textValue;
  Function onTap;

  BackCustomUI({Key key, this.actionWidget, this.textValue, this.onTap})
      : super(key: key);

  @override
  _BackCustomUIState createState() => _BackCustomUIState();
}

class _BackCustomUIState extends State<BackCustomUI> {
  bool backPressed = false;
  String textValue;

  @override
  void initState() {
    super.initState();
    textValue = widget.textValue != null ? widget.textValue : '';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(top: 6.h, left: 15.w),
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    backPressed = true;
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    backPressed = false;
                  });
                },
                child: SvgPicture.asset(
                  backPressed
                      ? "assets/icons/Button_Back_Idle.svg" //mistake name by designer
                      : 'assets/icons/Button_Back_Pressed.svg',
                  height: 36.h,
                  width: 36.w,
                ),
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ));
        },
      ),
      title: Text(textValue,
          style: latoSemiBold.copyWith(
            fontSize: 18.sp,
            wordSpacing: 1.0,
            fontWeight: FontWeight.w500,
          )),
      actions: <Widget>[widget.actionWidget],
    );
  }
}
