import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/more_option/bulb_time_counter_bloc.dart';
import 'package:neo/src/bloc/more_option/seconds_reciever_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:web_socket_channel/io.dart';

import 'package:circular_countdown/circular_countdown.dart';

class DotedCirc extends StatefulWidget {
  const DotedCirc({Key key}) : super(key: key);
  @override
  _DotedCircState createState() => _DotedCircState();
}

class _DotedCircState extends State<DotedCirc> {
  int countdownTotal = 60;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondsRecieverBloc, int>(
      builder: (context, seconds) {
        return Center(
          child: CircularCountdown(
            strokeWidth: 16,
            countdownRemainingColor: HexColor.dedGray(),
            countdownTotalColor: HexColor.neoBlue(),
            gapFactor: 2,
            countdownTotal: countdownTotal,
            countdownRemaining: countdownTotal - seconds,
          ),
        );
      },
    );
  }
}
