import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class SdCardsList extends StatefulWidget {
  // final String url;

  const SdCardsList({Key key}) : super(key: key);
  @override
  _SdCardsListState createState() => _SdCardsListState();
}

class _SdCardsListState extends State<SdCardsList>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool isActive = true;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.value = 0;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Container(
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#030303"),
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(children: [
              Expanded(
                  child: Row(
                children: [
                  SizedBox(
                    width: 6.sp,
                  ),
                  sdCardIcon(),
                  SizedBox(
                    width: 12.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        "SanDisk",
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#3498DB").withOpacity(0.9),
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: 1.sp,
                      ),
                      Text(
                        "Free 128gb out of 256gb".toUpperCase(),
                        style: latoSemiBold.copyWith(
                            color: HexColor.fromHex("#EDEFF0"),
                            fontSize: 13.sp),
                      ),
                      SizedBox(
                        height: 3.sp,
                      ),
                      SizedBox(
                          width: 220.w,
                          child: BlocBuilder<LiveViewBloc, bool>(
                              builder: (context, isIt) {
                            print("isKeyFrame");
                            print(isIt);
                            if (isIt) {
                              controller.animateTo(1,
                                  duration: const Duration(seconds: 5));
                              context.read<LiveViewBloc>().add(false);
                            }
                            return LinearProgressIndicator(
                              value: controller.value,
                              backgroundColor: HexColor.fromHex("#EDEFF0"),
                            );
                          })),
                      SizedBox(
                        height: 6.sp,
                      ),
                    ],
                  ),
                ],
              ))
            ]),
          ),
        ],
      ),
    );
  }

  Widget sdCardIcon() {
    return SvgPicture.asset(
      "assets/icons/Icon_StorageSDCard.svg",
      height: 56.h,
      width: 56.w,
    );
  }
}
