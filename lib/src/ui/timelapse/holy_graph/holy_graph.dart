import 'package:flutter/material.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/ui/custom_widgets/svg_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HolyGraph extends StatefulWidget {
  final List<HolyGRaphModel> chartDataShutter;
  final List<HolyGRaphModel> chartDatainterval;
  final List<HolyGRaphModel> chartDataIso;
  final List<HolyGRaphModel> chartDataFstop;
  final List<KeyFrameItem> selectedshutter;
  final bool showGradient;
  HolyGraph(
      {@required this.chartDataShutter,
      @required this.chartDatainterval,
      @required this.chartDataIso,
      @required this.chartDataFstop,
      this.showGradient = false,
      this.selectedshutter});

  factory HolyGraph.random() {
    final List<HolyGRaphModel> chartDataShutter = [
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: 1),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 1, 0), yValue: 9),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 4, 0), yValue: 9),
    ];
    final List<HolyGRaphModel> chartDatainterval = [
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: 1),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 1, 30), yValue: 8),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 4, 0), yValue: 8),
    ];
    final List<HolyGRaphModel> chartDataIso = [
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: 1),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 0, 30), yValue: 1),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 1, 30), yValue: 5),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 4, 0), yValue: 5),
    ];
    final List<HolyGRaphModel> chartDataFstop = [
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: 2),
      HolyGRaphModel(xValue: DateTime(0, 0, 0, 0, 04, 0), yValue: 2),
    ];
    return HolyGraph(
      chartDataShutter: chartDataShutter,
      chartDatainterval: chartDatainterval,
      chartDataIso: chartDataIso,
      chartDataFstop: chartDataFstop,
      showGradient: false,
    );
  }

  @override
  _HolyGraphState createState() => _HolyGraphState();
}

class _HolyGraphState extends State<HolyGraph> {
  @override
  Widget build(BuildContext context) {
    int hour = NeoBlocProvider.of(context).hourBloc.current;
    int min = NeoBlocProvider.of(context).minBloc.current;
    print("hours $hour");
    return SfCartesianChart(
      plotAreaBackgroundColor: HexColor.fromHex("#030303"),
      plotAreaBorderColor: Colors.transparent,
      // margin: EdgeInsets.only(top: 0),]
      selectionType: SelectionType.point,
      onMarkerRender: (markerArgs) {
        if (markerArgs.pointIndex == 0) {
          markerArgs.markerHeight = 0.0;
          markerArgs.markerWidth = 0.0;
          markerArgs.shape = DataMarkerType.none;
        }
        if (markerArgs.color == HexColor.fromHex('#DC143C')) {
          if (markerArgs.pointIndex == (widget.chartDataShutter.length - 1)) {
            markerArgs.markerHeight = 0.0;
            markerArgs.markerWidth = 0.0;

            markerArgs.shape = DataMarkerType.none;
          } else {
            try {
              if (widget.selectedshutter != null) {
                HolyGRaphModel model =
                    widget.chartDataShutter[markerArgs.pointIndex];
                KeyFrameItem ite = widget.selectedshutter
                    .where((element) =>
                        element.dateTime == model.xValue &&
                        element.keyFrameINdex == model.yValue)
                    .first;
                if (ite != null) {
                  markerArgs.markerWidth = 15.h;
                  markerArgs.markerHeight = 15.h;
                  markerArgs.color = HexColor.fromHex('#ED8A9E');

                  markerArgs.borderColor = HexColor.fromHex('#ED8A9E');
                }
              }
            } catch (e) {
              print("$e");
            }
          }
        }

        if (markerArgs.color == HexColor.fromHex('#FFBF00')) {
          if (markerArgs.pointIndex == (widget.chartDatainterval.length - 1)) {
            markerArgs.markerHeight = 0.0;
            markerArgs.markerWidth = 0.0;
            markerArgs.shape = DataMarkerType.triangle;
          } else {
            try {
              if (widget.selectedshutter != null) {
                HolyGRaphModel model =
                    widget.chartDatainterval[markerArgs.pointIndex];
                KeyFrameItem ite = widget.selectedshutter
                    .where((element) =>
                        element.dateTime == model.xValue &&
                        element.keyFrameINdex == model.yValue)
                    .first;
                if (ite != null) {
                  markerArgs.markerWidth = 15.h;
                  markerArgs.markerHeight = 15.h;
                  markerArgs.color = HexColor.fromHex('#FFDF80');

                  markerArgs.borderColor = HexColor.fromHex('#FFDF80');
                }
              }
            } catch (e) {
              print("$e");
            }
          }
        }
        if (markerArgs.color == HexColor.fromHex('#00FFFF')) {
          if (markerArgs.pointIndex == (widget.chartDataIso.length - 1)) {
            print("here me");
            markerArgs.markerHeight = 0.0;
            markerArgs.markerWidth = 0.0;
            markerArgs.color = Colors.transparent;

            markerArgs.shape = DataMarkerType.none;
          } else {
            try {
              if (widget.selectedshutter != null) {
                HolyGRaphModel model =
                    widget.chartDataIso[markerArgs.pointIndex];
                KeyFrameItem ite = widget.selectedshutter
                    .where((element) =>
                        element.dateTime == model.xValue &&
                        element.keyFrameINdex == model.yValue)
                    .first;
                if (ite != null) {
                  markerArgs.markerWidth = 15.h;
                  markerArgs.markerHeight = 15.h;
                  markerArgs.color = HexColor.fromHex('#80FFFF');

                  markerArgs.borderColor = HexColor.fromHex('#80FFFF');
                }
              }
            } catch (e) {
              print("$e");
            }
          }
        }
        if (markerArgs.color == HexColor.fromHex('#00FF00')) {
          if (markerArgs.pointIndex == (widget.chartDataFstop.length - 1)) {
            markerArgs.markerHeight = 0.0;
            markerArgs.markerWidth = 0.0;
            markerArgs.shape = DataMarkerType.triangle;
          } else {
            try {
              if (widget.selectedshutter != null) {
                HolyGRaphModel model =
                    widget.chartDataFstop[markerArgs.pointIndex];
                print("fstop not null ${model.xValue}");
                KeyFrameItem ite = widget.selectedshutter
                    .where((element) =>
                        element.dateTime == model.xValue &&
                        element.keyFrameINdex == model.yValue)
                    .first;
                if (ite != null) {
                  markerArgs.markerWidth = 15.h;
                  markerArgs.markerHeight = 15.h;
                  markerArgs.color = HexColor.fromHex('#80FF80');

                  markerArgs.borderColor = HexColor.fromHex('#80FF80');
                }
              }
            } catch (e) {
              print("$e");
            }
          }
        }
      },
      //   backgroundColor: Colors.white,
      primaryXAxis: DateTimeAxis(
        isVisible: true,
        tickPosition: TickPosition.inside,
        majorTickLines: MajorTickLines(color: Colors.transparent),
        axisLine: AxisLine(color: Colors.transparent, width: 0),
        labelStyle: latoSemiBold.copyWith(
            color: HexColor.fromHex("#959FA5"), fontSize: 10.sp),
        intervalType: DateTimeIntervalType.seconds,
        majorGridLines: MajorGridLines(
            width: 0.1, color: HexColor.dedGray(), dashArray: [10.0, 1.1]),
        labelPosition: ChartDataLabelPosition.outside,
        desiredIntervals: 8,
        maximum: DateTime(0, 0, 0, hour, min == 0 && hour == 0 ? 30 : min, 0),
      ),
      primaryYAxis: NumericAxis(
          // edgeLabelPlacement: EdgeLabelPlacement.hide,
          labelPosition: ChartDataLabelPosition.outside,
          isVisible: false),
      series: <ChartSeries>[
        if (widget.chartDataShutter != null)
          AreaSeries<HolyGRaphModel, DateTime>(
              dataSource: widget.chartDataShutter,
              borderColor: HexColor.fromHex('#DC143C'),
              borderWidth: 2,
              //  trendlines: [Trendline()],

              selectionBehavior:
                  SelectionBehavior(enable: true, selectedColor: Colors.blue),
              gradient: widget.showGradient
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                          HexColor.fromHex('#DC143C').withOpacity(0.2),
                          HexColor.fromHex('#DC143C').withOpacity(0.0),
                        ])
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent]),
              markerSettings: MarkerSettings(
                color: HexColor.fromHex('#DC143C'),
                isVisible: true,
                height: 15.h,
                width: 15.h,
                //  image: SvgWidget( "assets/icons/Icon_KeypointShutterSpeed_Disable.svg"),
                shape: DataMarkerType.diamond,
                borderColor: HexColor.fromHex('#DC143C'),
              ),
              xValueMapper: (HolyGRaphModel sales, _) => sales.xValue,
              yValueMapper: (HolyGRaphModel sales, _) => sales.yValue),
        // : LineSeries<HolyGRaphModel, DateTime>(
        //     dataSource: widget.chartDataShutter,
        //     color: HexColor.fromHex('#DC143C'),
        //     markerSettings: MarkerSettings(
        //         color: HexColor.fromHex('#DC143C'),
        //         isVisible: true,
        //         height: 15.h,
        //         width: 15.h,
        //         shape: DataMarkerType.diamond,
        //         borderColor: HexColor.fromHex('#DC143C')),
        //     xValueMapper: (HolyGRaphModel sales, _) => sales.xValue,
        //     yValueMapper: (HolyGRaphModel sales, _) => sales.yValue),
        if (widget.chartDatainterval != null)
          AreaSeries<HolyGRaphModel, DateTime>(
              dataSource: widget.chartDatainterval,
              borderColor: HexColor.fromHex('#FFBF00'),
              borderWidth: 2,
              gradient: widget.showGradient
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                          HexColor.fromHex('#FFBF00').withOpacity(0.2),
                          HexColor.fromHex('#FFBF00').withOpacity(0.0),
                        ])
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent]),
              markerSettings: MarkerSettings(
                color: HexColor.fromHex('#FFBF00'),
                isVisible: true,
                height: 15.h,
                width: 15.h,
                shape: DataMarkerType.diamond,
                borderColor: HexColor.fromHex('#FFBF00'),
              ),
              xValueMapper: (HolyGRaphModel sales, _) => sales.xValue,
              yValueMapper: (HolyGRaphModel sales, _) => sales.yValue),
        if (widget.chartDataIso != null)
          AreaSeries<HolyGRaphModel, DateTime>(
              dataSource: widget.chartDataIso,
              borderColor: HexColor.fromHex('#00FFFF'),
              borderWidth: 2,
              selectionBehavior: SelectionBehavior(
                  enable: true, selectedBorderColor: Colors.red),
              gradient: widget.showGradient
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                          HexColor.fromHex('#00FFFF').withOpacity(0.2),
                          HexColor.fromHex('#00FFFF').withOpacity(0.0),
                        ])
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent]),
              markerSettings: MarkerSettings(
                color: HexColor.fromHex('#00FFFF'),
                isVisible: true,
                height: 15.h,
                width: 15.h,
                shape: DataMarkerType.diamond,
                borderColor: HexColor.fromHex('#00FFFF'),
              ),
              color: HexColor.fromHex('#00FFFF'),
              xValueMapper: (HolyGRaphModel sales, _) => sales.xValue,
              yValueMapper: (HolyGRaphModel sales, _) => sales.yValue),

        if (widget.chartDataFstop != null)
          AreaSeries<HolyGRaphModel, DateTime>(
              dataSource: widget.chartDataFstop,
              borderColor: HexColor.fromHex('#00FF00'),
              borderWidth: 2,
              gradient: widget.showGradient
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                          HexColor.fromHex('#00FF00').withOpacity(0.2),
                          HexColor.fromHex('#00FF00').withOpacity(0.0),
                        ])
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent]),
              markerSettings: MarkerSettings(
                color: HexColor.fromHex('#00FF00'),
                isVisible: true,
                height: 15.h,
                width: 15.h,
                shape: DataMarkerType.diamond,
                borderColor: HexColor.fromHex('#00FF00'),
              ),
              xValueMapper: (HolyGRaphModel sales, _) => sales.xValue,
              yValueMapper: (HolyGRaphModel sales, _) => sales.yValue),
      ],
    );
  }
}

class HolyGRaphModel {
  DateTime xValue;
  int yValue;
  HolyGRaphModel({
    @required this.xValue,
    @required this.yValue,
  });
}
