import 'package:flutter/material.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/model/histo_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChart extends StatelessWidget {
  final List<HistoModel> chartDataBlue;
  final List<HistoModel> chartDataGreen;
  final List<HistoModel> chartDataRed;

  SplineChart(
      {@required this.chartDataBlue,
      @required this.chartDataGreen,
      @required this.chartDataRed});

  @override
  Widget build(BuildContext context) {
    if (this.chartDataBlue.isNotEmpty) {
      return SfCartesianChart(
        plotAreaBorderWidth: 2,
        plotAreaBorderColor: HexColor.fromHex("#1D5378").withOpacity(0.2),
        margin: EdgeInsets.all(0),
        plotAreaBackgroundColor: HexColor.fromHex("#3498DB").withOpacity(0.2),
        primaryXAxis: NumericAxis(
          isVisible: false,
          labelPosition: ChartDataLabelPosition.inside,
        ),
        primaryYAxis: NumericAxis(
          enableAutoIntervalOnZooming: false,
          labelPosition: ChartDataLabelPosition.inside,
          isVisible: false,
        ),
        series: <ChartSeries>[
          SplineAreaSeries<HistoModel, int>(
              dataSource: chartDataBlue,
              opacity: 0.7,
              color: HexColor.fromHex("#3498DB").withOpacity(0),
              xValueMapper: (HistoModel sales, _) => sales.xValue,
              yValueMapper: (HistoModel sales, _) => sales.yValue),
          SplineAreaSeries<HistoModel, int>(
              dataSource: chartDataRed,
              opacity: 0.7,
              color: HexColor.fromHex("#F53C61").withOpacity(0),
              xValueMapper: (HistoModel sales, _) => sales.xValue,
              yValueMapper: (HistoModel sales, _) => sales.yValue),
          SplineAreaSeries<HistoModel, int>(
              dataSource: chartDataGreen,
              opacity: 0.7,
              color: HexColor.fromHex("#50FCA8").withOpacity(0),
              xValueMapper: (HistoModel sales, _) => sales.xValue,
              yValueMapper: (HistoModel sales, _) => sales.yValue),
        ],
      );
    } else {
      return Container();
    }
  }
}
