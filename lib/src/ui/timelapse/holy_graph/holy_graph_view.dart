import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/selected_params_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/neo_bloc_provider.dart';
import 'package:neo/src/model/keyframe/keyframe_item.dart';
import 'package:neo/src/bloc/timelapse/duration/hour_bloc.dart';
import 'package:neo/src/bloc/timelapse/duration/minute_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/final_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/fstop/initial_fstop_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/final_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/interval/initial_interval_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/final_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/iso/initial_iso_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/higlited_keyframe_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_bloc.dart';
import 'package:neo/src/bloc/timelapse/keyframe/keyframe_tab_state.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/final_shutter_sp_bloc.dart';
import 'package:neo/src/bloc/timelapse/shutter_speed/initial_shutter_sp_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/model/keyframe/h_holy_item_model.dart';
import 'package:neo/src/model/keyframe/keyframe_shutter_model.dart';
import 'package:provider/provider.dart';

import 'graph_value_row.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'holy_graph.dart';
import 'holy_graph_list_model.dart';

class HolyGraphView extends StatefulWidget {
  @override
  _HolyGraphViewState createState() => _HolyGraphViewState();
}

class _HolyGraphViewState extends State<HolyGraphView> {
  final String isoIconEnable = "assets/icons/Icon_KeypointISO_Enable.svg";
  final String isoIconDisable = "assets/icons/Icon_KeypointISO_Disable.svg";

  final String interEnable = "assets/icons/Icon_KeypointInterval_Enable.svg";
  final String interDisable = "assets/icons/Icon_KeypointInterval_Disable.svg";

  final String shutEnable = "assets/icons/Icon_KeypointShutterSpeed_Enable.svg";
  final String shutDisable =
      "assets/icons/Icon_KeypointShutterSpeed_Disable.svg";

  final String fstopEnable = "assets/icons/Icon_KeypointFStop_Enable.svg";
  final String fstopEDisable = "assets/icons/Icon_KeypointFStop_Disable.svg";

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyFrameModel>(builder: (context, shutterList, child) {
      List<KeyFrameItem> chartDataMain = [];
      List<HolyGRaphModel> chartDataIso = [];
      List<HolyGRaphModel> chartDataFStop = [];
      List<HolyGRaphModel> chartDataShutter = [];
      List<HolyGRaphModel> chartDataInterval = [];

      HSelectedItem isoInitial = context.read<InitialIsoBloc>().state;
      HSelectedItem shutterInitial = context.read<InitialShutterSpBloc>().state;
      HSelectedItem fstopInitial = context.read<InitialFstopBloc>().state;
      int intervalInitial = context.read<InitialIntervalBloc>().sec;

      //FOR ISO
      chartDataIso.add(HolyGRaphModel(
          xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: isoInitial.index));
      //FOR FSTOP
      chartDataFStop.add(HolyGRaphModel(
          xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: fstopInitial.index));
      //FOR SHUTTER
      chartDataShutter.add(HolyGRaphModel(
          xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: shutterInitial.index));
      //FOR INTERVAL
      chartDataInterval.add(HolyGRaphModel(
          xValue: DateTime(0, 0, 0, 0, 0, 0), yValue: intervalInitial));

      //ISO
      shutterList.isoItemList.forEach((element) {
        chartDataIso.add(HolyGRaphModel(
            xValue: element.dateTime, yValue: element.keyFrameINdex));
      });
      //SHUTTER
      shutterList.shutterItemList.forEach((element) {
        chartDataShutter.add(HolyGRaphModel(
            xValue: element.dateTime, yValue: element.keyFrameINdex));
      });
      //FSTOP
      shutterList.fstoptemList.forEach((element) {
        chartDataFStop.add(HolyGRaphModel(
            xValue: element.dateTime, yValue: element.keyFrameINdex));
      });
      //INTERVAL
      shutterList.intervaltemList.forEach((element) {
        chartDataInterval.add(HolyGRaphModel(
            xValue: element.dateTime, yValue: element.keyFrameINdex));
      });

      HSelectedItem isoFinal = context.read<FinalIsoBloc>().state;
      HSelectedItem shutterFinal = context.read<FinalShutterSpBloc>().state;
      HSelectedItem fstopFinal = context.read<FinalFstopBloc>().state;
      int intervalFinal = context.read<FinalIntervalBloc>().sec;

      int hour = NeoBlocProvider.of(context).hourBloc.current;
      int min = NeoBlocProvider.of(context).minBloc.current;

      if (hour != null && min != null) {
        //FOR ISO
        chartDataIso.add(HolyGRaphModel(
            xValue:
                DateTime(0, 0, 0, hour, min == 0 && hour == 0 ? 30 : min, 0),
            yValue: isoFinal.index));
        //FOR FSTOP
        chartDataFStop.add(HolyGRaphModel(
            xValue:
                DateTime(0, 0, 0, hour, min == 0 && hour == 0 ? 30 : min, 0),
            yValue: fstopFinal.index));
        //FOR SHUTTER
        chartDataShutter.add(HolyGRaphModel(
            xValue:
                DateTime(0, 0, 0, hour, min == 0 && hour == 0 ? 30 : min, 0),
            yValue: shutterFinal.index));
        //FOR INTERVAL
        chartDataInterval.add(HolyGRaphModel(
            xValue:
                DateTime(0, 0, 0, hour, min == 0 && hour == 0 ? 30 : min, 0),
            yValue: intervalFinal));

        //SORT Iso
        chartDataIso.sort((a, b) {
          int i = 0;
          bool isIt = a.xValue.isAfter(b.xValue);
          if (isIt) {
            i = 1;
          }
          return i;
        });

        //SORT SHUTTER
        chartDataShutter.sort((a, b) {
          int i = 0;
          bool isIt = a.xValue.isAfter(b.xValue);
          if (isIt) {
            i = 1;
          }
          return i;
        });

        //SORT FSTOP
        chartDataFStop.sort((a, b) {
          int i = 0;
          bool isIt = a.xValue.isAfter(b.xValue);
          if (isIt) {
            i = 1;
          }
          return i;
        });

        //SORT INTERVAL
        chartDataInterval.sort((a, b) {
          int i = 0;
          bool isIt = a.xValue.isAfter(b.xValue);
          if (isIt) {
            i = 1;
          }
          return i;
        });

        chartDataMain.addAll(shutterList.isoItemList);
        chartDataMain.addAll(shutterList.shutterItemList);
        chartDataMain.addAll(shutterList.fstoptemList);
        chartDataMain.addAll(shutterList.intervaltemList);

        return BlocConsumer<SelectedParamsTabBloc, int>(
          listener: (context, tabState) {},
          builder: (context, index) => Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#3498DB").withOpacity(0.05),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    border: Border.all(
                        width: 2, color: HexColor.fromHex("#1D1D1F")),
                  ),
                  child:
                      BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => Column(
                      children: [
                        Container(
                          height: 264.h,
                          child: Stack(children: [
                            Container(
                              height: 235.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#030303"),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0))),
                            ),
                            if (index == 2)
                              HolyGraph(
                                chartDataFstop: null,
                                chartDataIso: chartDataIso,
                                chartDataShutter: null,
                                chartDatainterval: null,
                                showGradient: true,
                                selectedshutter: selectedItems,
                              )
                            else if (index == 1)
                              HolyGraph(
                                chartDataFstop: chartDataFStop,
                                chartDataIso: null,
                                chartDataShutter: null,
                                chartDatainterval: null,
                                showGradient: true,
                                selectedshutter: selectedItems,
                              )
                            else if (index == 0)
                              HolyGraph(
                                chartDataFstop: null,
                                chartDataIso: null,
                                chartDataShutter: chartDataShutter,
                                chartDatainterval: null,
                                showGradient: true,
                                selectedshutter: selectedItems,
                              )
                            else if (index == 4)
                              HolyGraph(
                                chartDataFstop: null,
                                chartDataIso: null,
                                chartDataShutter: null,
                                chartDatainterval: chartDataInterval,
                                showGradient: true,
                                selectedshutter: selectedItems,
                              )
                            // else
                            //   HolyGraph(
                            //     chartDataFstop: chartDataFStop,
                            //     chartDataIso: chartDataIso,
                            //     chartDataShutter: chartDataShutter,
                            //     chartDatainterval: chartDataInterval,
                            //     showGradient: false,
                            //     selectedshutter: selectedItems,
                            //   ),
                          ]),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 6.h,
              ),
              if (index == 2)
                for (var item in shutterList.isoItemList)
                  BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => GraphValueRow(
                      isSelected: selectedItems.contains(item),
                      iconColor:
                          returnColor(selectedItems.contains(item), item.type),
                      onTap: (selected) {
                        if (selected) {
                          context.read<HighLightedKeyFrameBloc>().addItem(item);
                        } else {
                          context
                              .read<HighLightedKeyFrameBloc>()
                              .removeItem(item);
                        }
                      },
                      model: HolyGraphListModel(
                          dateTime: item.dateTime,
                          curveType: item.type,
                          iconDisabled: returnIconDisable(item.type),
                          iconEnabled: returnIconEnable(item.type),
                          keyFrameItem: item),
                    ),
                  )
              else if (index == 0)
                for (var item in shutterList.shutterItemList)
                  BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => GraphValueRow(
                      isSelected: selectedItems.contains(item),
                      iconColor:
                          returnColor(selectedItems.contains(item), item.type),
                      onTap: (selected) {
                        if (selected) {
                          context.read<HighLightedKeyFrameBloc>().addItem(item);
                        } else {
                          context
                              .read<HighLightedKeyFrameBloc>()
                              .removeItem(item);
                        }
                      },
                      model: HolyGraphListModel(
                          dateTime: item.dateTime,
                          curveType: item.type,
                          iconDisabled: returnIconDisable(item.type),
                          iconEnabled: returnIconEnable(item.type),
                          keyFrameItem: item),
                    ),
                  )
              else if (index == 1)
                for (var item in shutterList.fstoptemList)
                  BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => GraphValueRow(
                      isSelected: selectedItems.contains(item),
                      iconColor:
                          returnColor(selectedItems.contains(item), item.type),
                      onTap: (selected) {
                        if (selected) {
                          context.read<HighLightedKeyFrameBloc>().addItem(item);
                        } else {
                          context
                              .read<HighLightedKeyFrameBloc>()
                              .removeItem(item);
                        }
                      },
                      model: HolyGraphListModel(
                          dateTime: item.dateTime,
                          curveType: item.type,
                          iconDisabled: returnIconDisable(item.type),
                          iconEnabled: returnIconEnable(item.type),
                          keyFrameItem: item),
                    ),
                  )
              else if (index == 4)
                for (var item in shutterList.intervaltemList)
                  BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => GraphValueRow(
                      isSelected: selectedItems.contains(item),
                      iconColor:
                          returnColor(selectedItems.contains(item), item.type),
                      onTap: (selected) {
                        if (selected) {
                          context.read<HighLightedKeyFrameBloc>().addItem(item);
                        } else {
                          context
                              .read<HighLightedKeyFrameBloc>()
                              .removeItem(item);
                        }
                      },
                      model: HolyGraphListModel(
                          dateTime: item.dateTime,
                          curveType: item.type,
                          iconDisabled: returnIconDisable(item.type),
                          iconEnabled: returnIconEnable(item.type),
                          keyFrameItem: item),
                    ),
                  )
              else
                for (KeyFrameItem item in chartDataMain)
                  BlocBuilder<HighLightedKeyFrameBloc, List<KeyFrameItem>>(
                    builder: (context, selectedItems) => GraphValueRow(
                      isSelected: selectedItems.contains(item),
                      iconColor:
                          returnColor(selectedItems.contains(item), item.type),
                      onTap: (selected) {
                        if (selected) {
                          context.read<HighLightedKeyFrameBloc>().addItem(item);
                        } else {
                          context
                              .read<HighLightedKeyFrameBloc>()
                              .removeItem(item);
                        }
                      },
                      model: HolyGraphListModel(
                          dateTime: item.dateTime,
                          curveType: item.type,
                          iconDisabled: returnIconDisable(item.type),
                          iconEnabled: returnIconEnable(item.type),
                          keyFrameItem: item),
                    ),
                  )
            ],
          ),
        );
      }
      return Container();
    });
  }

  String returnIconEnable(String type) {
    switch (type) {
      case "ISO":
        return isoIconEnable;
        break;
      case "SHUTTER":
        return shutEnable;
        break;
      case "FSTOP":
        return fstopEnable;
        break;
      case "INTERVAL":
        return interEnable;
        break;
      default:
        return "isoIconEnable";
    }
  }

  String returnIconDisable(String type) {
    switch (type) {
      case "ISO":
        return isoIconDisable;
        break;
      case "SHUTTER":
        return shutDisable;
        break;
      case "FSTOP":
        return fstopEDisable;
      case "INTERVAL":
        return interDisable;
        break;
      default:
        return "shutDisable";
    }
  }

  Color returnColor(bool selected, String type) {
    switch (type) {
      case "ISO":
        return selected
            ? HexColor.fromHex("#80FFFF")
            : HexColor.fromHex("#00FFFF");
        break;
      case "SHUTTER":
        return selected
            ? HexColor.fromHex("#ED8A9E")
            : HexColor.fromHex("#DC143C");
        break;
      case "FSTOP":
        return selected
            ? HexColor.fromHex("#80FF80")
            : HexColor.fromHex("#00FF00");
      case "INTERVAL":
        return selected
            ? HexColor.fromHex("#FFDF80")
            : HexColor.fromHex("#FFBF00");
        break;
      default:
        return selected
            ? HexColor.fromHex("#FFDF80")
            : HexColor.fromHex("#FFBF00");
    }
  }
}
