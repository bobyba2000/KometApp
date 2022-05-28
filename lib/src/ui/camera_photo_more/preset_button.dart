import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

class PresetButton extends StatefulWidget {
  @override
  _PresetButtonState createState() => _PresetButtonState();
}

class _PresetButtonState extends State<PresetButton> {
  _PressButtonBloc __pressButtonBloc;

  @override
  void initState() {
    __pressButtonBloc = _PressButtonBloc();
    super.initState();
  }

  @override
  void dispose() {
    __pressButtonBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showD();
      },
      onTapDown: (details) {
        __pressButtonBloc.add(true);
      },
      onTapUp: (details) {
        __pressButtonBloc.add(false);
      },
      child: Container(
          width: 100.w,
          height: 45.h,
          child: BlocBuilder<_PressButtonBloc, bool>(
            bloc: __pressButtonBloc,
            builder: (context, state) => Center(
              child: Text(
                "SAVE PRESET",
                style: latoSemiBold.copyWith(
                  color: Colors.transparent,
                  fontSize: 15.sp,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      !state ? HexColor.neoBlue() : HexColor.neoBlueDisable(),
                  shadows: [
                    Shadow(
                        color: !state
                            ? HexColor.neoBlue()
                            : HexColor.neoBlueDisable(),
                        offset: Offset(0, -3))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  showD() {
    Widget cont = new CupertinoAlertDialog(
      title: new Text(
        "Please set name of your preset",
        style: TextStyle(fontSize: 14),
      ),
      content: Material(
        color: Colors.transparent,
        child: Container(
          height: 35.h,
          margin: EdgeInsets.only(top: 30.h),
          color: Colors.white,
          child: TextField(
            decoration: InputDecoration(fillColor: Colors.white),
          ),
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("Okay"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (context) => cont,
    );
  }
}

class _PressButtonBloc extends Bloc<bool, bool> {
  _PressButtonBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
