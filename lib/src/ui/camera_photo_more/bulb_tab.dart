import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_event.dart';
import 'package:neo/src/bloc/more_option/bulb_type/bulb_type_state.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/ui/custom_widgets/usable_widgets/increase_tap_area.dart';

class BulbTab extends StatefulWidget {
  @override
  _BulbTabState createState() => _BulbTabState();
}

class _BulbTabState extends State<BulbTab> {
  int curBulb = 0;
  List<BulbModel> bubles = [
    BulbModel(
        leadingLabel: "SHOT",
        state: BulbTypeStateShot(),
        subtitle: "Trigger by Time"),
    BulbModel(
        leadingLabel: "TAP",
        state: BulbTypeStateTap(),
        subtitle: "Trigger by Tap Open and Tap Close"),
    BulbModel(
        leadingLabel: "HOLD",
        state: BulbTypeStateHold(),
        subtitle: "Trigger by Tap and Hold")
  ];

  @override
  void initState() {
    super.initState();
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
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.h),
            decoration: BoxDecoration(
                border: Border.all(color: HexColor.neoGray()),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(children: [
              for (int i = 0; i < bubles.length; i++)
                Container(
                  height: 40.h,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<BulbTypeBloc>()
                          .add(setEvent(bubles[i].state));
                      setState(() {
                        curBulb = i;
                      });
                    },
                    child: ExpandedHitTestArea(
                      child: Row(
                        children: [
                          leadingWidget(curBulb == i, bubles[i].leadingLabel),
                          SizedBox(
                            width: 12.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bubles[i].state.name}",
                                style: latoSemiBold.copyWith(
                                    color: curBulb == i
                                        ? HexColor.fromHex("#EDEFF0")
                                        : HexColor.fromHex("#959FA5"),
                                    fontSize: 15.sp),
                              ),
                              Text(
                                "${bubles[i].subtitle}",
                                style: latoSemiBold.copyWith(
                                    color: HexColor.fromHex("#3E505B"),
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      HexColor.neoBlueDisable(),
                                ),
                                child: Radio(
                                  value: curBulb == i,
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      curBulb = i;
                                    });
                                  },
                                )),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
            ]),
          ),
        ],
      ),
    );
  }

  BulbTypeEvent setEvent(BulbTypeState state) {
    if (state is BulbTypeStateShot) {
      return BulbTypeEventShot();
    }
    if (state is BulbTypeStateTap) {
      return BulbTypeEventTap();
    }

    return BulbTypeEventHold();
  }

  Widget leadingWidget(bool active, String labelLeading) {
    return Stack(
      children: [
        SvgPicture.asset(
          active
              ? "assets/icons/Button_BulbTrigger_Enable.svg"
              : "assets/icons/Button_BulbTrigger_Disable.svg",
          height: 36.h,
          width: 36.w,
        ),
        Positioned.fill(
            child: Center(
          child: Text(
            "$labelLeading",
            style: latoSemiBold.copyWith(
                color: HexColor.fromHex("#EDEFF0"), fontSize: 10.sp),
          ),
        ))
      ],
    );
  }
}

class BulbModel {
  String leadingLabel;
  BulbTypeState state;
  String subtitle;
  BulbModel({
    @required this.leadingLabel,
    @required this.state,
    @required this.subtitle,
  });
}
