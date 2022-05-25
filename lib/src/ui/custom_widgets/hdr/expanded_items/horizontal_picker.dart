import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_bloc.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_event.dart';
import 'package:neo/src/bloc/hdr/hdr_sequence_state.dart';
import 'package:neo/src/bloc/step_bracket_values/step_bracket_values_bloc.dart';
import 'package:neo/src/constants/constants.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/model/capture_button_model.dart';
import 'package:neo/src/model/shutters.dart';
import 'package:neo/src/ui/custom_widgets/hdr/expanded_items/knob_button.dart';
import 'package:neo/src/utils/utility.dart';
import 'package:provider/provider.dart';

import 'button_radio.dart';
import 'eab_l_button.dart';
import 'eab_r_button.dart';

class HorizontalPicker extends StatefulWidget {
  final StepBracketValuesBloc stepBracketValuesBloc;
  final bool expand;

  const HorizontalPicker({
    Key key,
    @required this.stepBracketValuesBloc,
    @required this.expand,
  }) : super(key: key);
  @override
  _HorizontalPickerState createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker>
    with TickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;
  static double heightWidget = 240.w;
  double height = heightWidget;

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      setState(() {
        height = heightWidget;
      });

      Future.delayed(Duration(milliseconds: 400)).then((value) {
        expandController.forward();
      });
    } else {
      expandController.reverse();
      Future.delayed(Duration(milliseconds: 400)).then((value) {
        setState(() {
          height = 0;
        });
      });
    }
  }

  @override
  void didUpdateWidget(HorizontalPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  HdrSequenceBloc _hdrSequenceBloc;

  final List<double> _values = [
    -9,
    -8.6,
    -8.3,
    -8.0,
    -7.6,
    -7.3,
    -7,
    -6.6,
    -6.3,
    -6,
    -5.6,
    -5.3,
    -5,
    -4.6,
    -4.3,
    -4,
    -3.6,
    -3.3,
    -3,
    -2.6,
    -2.3,
    -2,
    -1.6,
    -1.3,
    -1,
    -0.6,
    -0.3,
    0,
    0.3,
    0.6,
    1,
    1.3,
    1.6,
    2,
    2.3,
    2.6,
    3,
    3.3,
    3.6,
    4,
    4.3,
    4.6,
    5,
    5.3,
    5.6,
    6,
    6.3,
    6.6,
    7,
    7.3,
    7.6,
    8,
    8.3,
    8.6,
    9
  ];

  final List<double> _shifts = [
    -9,
    -8.7,
    -8.3,
    -8.0,
    -7.7,
    -7.3,
    -7,
    -6.7,
    -6.3,
    -6,
    -5.7,
    -5.3,
    -5,
    -4.7,
    -4.3,
    -4,
    -3.7,
    -3.3,
    -3,
    -2.7,
    -2.3,
    -2,
    -1.7,
    -1.3,
    -1,
    -0.7,
    -0.3,
    0,
    0.3,
    0.7,
    1,
    1.3,
    1.7,
    2,
    2.3,
    2.7,
    3,
    3.3,
    3.7,
    4,
    4.3,
    4.7,
    5,
    5.3,
    5.7,
    6,
    6.3,
    6.7,
    7,
    7.3,
    7.7,
    8,
    8.3,
    8.7,
    9
  ];

  int curIndex = 0;
  int midleIndex = 0;
  List<BracketItem> bracketIndexs = [];
  List<BracketItem> oldbracketIndexs = [];
  int oldmidleIndex;
  List<int> fstopIndexs = [];
  List<int> isoIndexs = [];
  List<int> shutterndexs = [];

  bool isShift = false;

  bool isInRange(int i, int range, int counter, {@required int count}) {
    int first = midleIndex;
    int last = midleIndex;

    double l = ((range - 1) / 2);

    if (midleIndex >= l) {
      first = midleIndex - l.toInt();
    }

    if (midleIndex <= _values.length) {
      last = midleIndex + l.toInt();
    }
    return i >= first && i <= last;
  }

  Future<List<Sequence>> loopMagic(
      {@required double step, @required int bracket}) async {
    List<Sequence> _shutters = [];

    if (step > 9) {
      throw ("step is out of bound, max is 9");
    }

    if (step > 3.7 && bracket == 5) {
      throw ("step is out of bound");
    }
    if (step > 2 && bracket == 7) {
      throw ("step is out of bound");
    }
    if (step > 2 && bracket == 9) {
      throw ("step is out of bound");
    }
    if (step > 1.7 && bracket == 11) {
      throw ("step is out of bound");
    }
    if (step > 1.3 && bracket == 13) {
      throw ("step is out of bound");
    }
    if (step > 1 && bracket == 15) {
      throw ("step is out of bound");
    }
    if (step > 1 && bracket == 17) {
      throw ("step is out of bound");
    }
    if (step > 1 && bracket == 19) {
      throw ("step is out of bound");
    }

    int range = checkSteps(bracket: bracket, step: step);
    int count = getStep(step);

    int counter = 0;

    int indexInBracket = 0;

    _shutters = [];

    bracketIndexs = [];

    if (_values.isNotEmpty) {
      for (var i = 0; i < _values.length; i++) {
        bool shouldpaint = false;
        if (isInRange(i, range, counter, count: count)) {
          if (counter == 0) {
            shouldpaint = true;
            counter = count;
          } else {
            counter--;
          }
        }
        if (shouldpaint) {
          HdrSequenceState state = HdrSequenceStateShutter();
          if (shutterndexs.contains(i)) {
            state = HdrSequenceStateShutter();
          }
          if (isoIndexs.contains(i)) {
            print("lenth of iso in bracket ${isoIndexs.toString()} i $i");
            state = HdrSequenceStateIso();
          }

          if (fstopIndexs.contains(i)) {
            state = HdrSequenceStateFstop();
          }

          bracketIndexs.add(BracketItem(index: i, state: state));
          try {
            if (isShift) {
              bracketIndexs[indexInBracket].state =
                  returnState(oldbracketIndexs[indexInBracket].state);
              if (indexInBracket < oldbracketIndexs.length) {
                indexInBracket = indexInBracket + 1;
              } else {
                indexInBracket = 0;
              }
            }
          } catch (e) {}
        }

        HdrSequenceState oldState;

        try {
          if (isShift) {
            if (oldbracketIndexs.isNotEmpty) {
              if (oldbracketIndexs.contains(oldbracketIndexs
                  .firstWhere((element) => element.index == i))) {
                if (oldmidleIndex == i) {
                  oldState = HdrSequenceStateCenterO();
                } else {
                  HdrSequenceState oState = oldbracketIndexs
                      .firstWhere((element) => element.index == i)
                      .state;
                  if (oState is HdrSequenceStateFstop) {
                    oldState = HdrSequenceStateFstopO();
                  }
                  if (oState is HdrSequenceStateIso) {
                    oldState = HdrSequenceStateIsoO();
                  }

                  if (oState is HdrSequenceStateShutter) {
                    oldState = HdrSequenceStateShutterO();
                  }
                }
              }
            }
          }
        } catch (e) {
          print("error $e");
        }
        HdrSequenceState thisState;

        try {
          thisState = bracketIndexs.firstWhere(
            (element) {
              return element.index == i;
            },
          ).state;
        } catch (e) {
          //  print("error $e");
        }
        print("thisState $thisState");

        // Sequence shat = Sequence(
        //     name: _values[i],
        //     isMin: i == 0,
        //     isMax: i == _values.length - 1,
        //     state: i == midleIndex
        //         ? HdrSequenceStateCenter()
        //         : shouldpaint
        //             ? oldState != null
        //                 ? oldState
        //                 : thisState
        //             : oldState != null
        //                 ? oldState
        //                 : HdrSequenceStateInitial(),
        //     heigh: _values[i] % 1 == 0 ? 30.0 : 18.0,
        //     width: i == midleIndex
        //         ? 4
        //         : shouldpaint
        //             ? 4
        //             : oldState != null
        //                 ? 4
        //                 : 2,
        //     showName: _values[i] % 1 == 0 ? true : false);
        Sequence shat = Sequence(
            name: _values[i],
            isMin: i == 0,
            isMax: i == _values.length - 1,
            state: i == midleIndex
                ? HdrSequenceStateCenter()
                : shouldpaint
                    ? thisState
                    : oldState != null
                        ? oldState
                        : HdrSequenceStateInitial(),
            heigh: _values[i] % 1 == 0 ? 30.0 : 18.0,
            width: i == midleIndex
                ? 4
                : shouldpaint
                    ? 4
                    : oldState != null
                        ? 4
                        : 2,
            showName: _values[i] % 1 == 0 ? true : false);
        _shutters.add(shat);
      }

      bracketIndexs.sort((a, b) => a.index.compareTo(b.index));

      List<String> sequences = [];
      int median = getMedianIndex(bracketIndexs);
      for (var i = 0; i < bracketIndexs.length; i++) {
        if (i != median) {
          if (bracketIndexs[i].state is HdrSequenceStateShutter) {
            sequences.add("SHUTTER");
          }
          if (bracketIndexs[i].state is HdrSequenceStateFstop) {
            sequences.add("FSTOP");
          }
          if (bracketIndexs[i].state is HdrSequenceStateIso) {
            sequences.add("ISO");
          }
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        int ig = _values.indexOf(_shutters[midleIndex].name);

        model.setShift = "${_shifts[ig]}";
        model.setSequence = sequences;
      });

      // print("indexs ${bracketIndexs.toString()}");
      if (_shutters[curIndex].state is HdrSequenceStateShutter) {
        _hdrSequenceBloc.add(HdrSequenceEventSwitchShutterSpeed());
      } else if (_shutters[curIndex].state is HdrSequenceStateFstop) {
        _hdrSequenceBloc.add(HdrSequenceEventSwitchFstop());
      } else if (_shutters[curIndex].state is HdrSequenceStateIso) {
        _hdrSequenceBloc.add(HdrSequenceEventSwitchIso());
      } else {
        _hdrSequenceBloc.add(HdrSequenceEventSwitchInitial());
      }
    }

    // return _shutters.map((e) {
    //   if (e.isMax) {
    //     e.color = "#DC143C";
    //   }
    //   return e;
    // }).toList();
    return _shutters;
  }

  HdrSequenceState returnState(HdrSequenceState state) {
    if (state is HdrSequenceStateShutterO) {
      return HdrSequenceStateShutter();
    }
    if (state is HdrSequenceStateIsoO) {
      return HdrSequenceStateIso();
    }
    if (state is HdrSequenceStateFstopO) {
      return HdrSequenceStateFstop();
    }
    return state;
  }

  CaptureButtonModel model;

  @override
  void initState() {
    prepareAnimations();
    _runExpandCheck();
    model = Provider.of<CaptureButtonModel>(context, listen: false);
    _hdrSequenceBloc = HdrSequenceBloc();
    curIndex = _values.indexOf(0.0);
    midleIndex = _values.indexOf(0.0);
    widget.stepBracketValuesBloc.currentChange.listen((event) {
      try {
        setState(() {
          curIndex = getMedian(bracketIndexs).index;
          fstopIndexs.clear();
          shutterndexs.clear();
          isoIndexs.clear();
        });
      } catch (e) {
        print(e);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    expandController.dispose();
    _hdrSequenceBloc.close();
    super.dispose();
  }

  final bool isActive = false;

  int moveForward(bool isShift) {
    if (!isShift) {
      int index = bracketIndexs.indexOf(
          bracketIndexs.firstWhere((element) => element.index == curIndex));
      print("lenth ${bracketIndexs.length}");
      if (bracketIndexs.length > index + 1) {
        return bracketIndexs[index + 1].index;
      }
      return bracketIndexs[index].index;
    } else {
      int val = curIndex + 1;
      if (val < _values.length) {
        curIndex = curIndex + 1;
        return curIndex;
      } else {
        return curIndex;
      }
    }
  }

  int moveBack(bool isShift) {
    if (!isShift) {
      int index = bracketIndexs.indexOf(
          bracketIndexs.where((element) => element.index == curIndex).first);
      print("lenth ${bracketIndexs.length}");
      if (index > 0) {
        return bracketIndexs[index - 1].index;
      }
      return bracketIndexs[index].index;
    } else {
      if (curIndex > 0) {
        curIndex = curIndex - 1;
        return curIndex;
      } else {
        return curIndex;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StepBracket>(
      stream: widget.stepBracketValuesBloc.currentStepBracket,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return FutureBuilder<List<Sequence>>(
            future: loopMagic(
                step: double.parse(snapshot.data.step),
                bracket: int.parse(snapshot.data.bracket)),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error}",
                    style: latoSemiBold.copyWith(color: Colors.red),
                  ),
                );
              }
              if (snapshot.hasData) {
                return SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -0.5,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 319.5.w,
                              child: Row(
                                children: [
                                  KnobButton(
                                    margin: margin(curIndex),
                                    value: snapshot.data[curIndex].name,
                                    shiftChanged: (isShift) {
                                      setState(() {
                                        this.isShift = isShift;
                                        if (isShift) {
                                          oldbracketIndexs = bracketIndexs;
                                          oldmidleIndex = midleIndex;
                                        } else {
                                          if (oldbracketIndexs.isNotEmpty) {
                                            fstopIndexs.clear();
                                            for (var i = 0;
                                                i < oldbracketIndexs.length;
                                                i++) {
                                              print(
                                                  "oldbracketIndexs : ${oldbracketIndexs[i].state} ");
                                              if (oldbracketIndexs[i].state
                                                  is HdrSequenceStateFstop) {
                                                fstopIndexs.add(
                                                    bracketIndexs[i].index);
                                              }
                                              if (oldbracketIndexs[i].state
                                                  is HdrSequenceStateIso) {
                                                isoIndexs.add(
                                                    bracketIndexs[i].index);
                                              }
                                              if (oldbracketIndexs[i].state
                                                  is HdrSequenceStateShutter) {
                                                shutterndexs.add(
                                                    bracketIndexs[i].index);
                                              }
                                            }
                                          }
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Container(),
                                )),
                                Container(
                                  width: 300.w,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: snapshot.hasData
                                        ? snapshot.data
                                            .map((Sequence curValue) {
                                            return ItemWidget(
                                              curItem: curValue,
                                            );
                                          }).toList()
                                        : [Container()],
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.w,
                                  ),
                                  child: Container(),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 12.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: EABlButton(
                                    onTap: () {
                                      setState(() {
                                        curIndex = moveBack(isShift);
                                        if (isShift) {
                                          midleIndex = curIndex;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 24.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.w,
                                  ),
                                  child: EABRButton(
                                    onTap: () {
                                      setState(() {
                                        curIndex = moveForward(isShift);
                                        if (isShift) {
                                          midleIndex = curIndex;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.5.h,
                            ),
                            BlocBuilder<HdrSequenceBloc, HdrSequenceState>(
                              bloc: _hdrSequenceBloc,
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonRadio(
                                      isActive:
                                          state is HdrSequenceStateShutter,
                                      bracketColor: "#DC143C",
                                      name: "SHUTTER SPEED",
                                      onTap: () {
                                        BracketItem item;
                                        try {
                                          item = bracketIndexs.firstWhere(
                                              (element) =>
                                                  element.index == curIndex);

                                          print("item is not null $item");
                                        } catch (e) {
                                          print("item is null");
                                        }

                                        if (item.index !=
                                            getMedian(bracketIndexs).index) {
                                          _hdrSequenceBloc.add(
                                              HdrSequenceEventSwitchShutterSpeed());
                                          if (!shutterndexs
                                              .contains(curIndex)) {
                                            if (isoIndexs.contains(curIndex)) {
                                              isoIndexs.remove(curIndex);
                                            }
                                            if (fstopIndexs
                                                .contains(curIndex)) {
                                              fstopIndexs.remove(curIndex);
                                            }
                                            setState(() {
                                              shutterndexs.add(curIndex);
                                            });
                                          } else {
                                            if (isoIndexs.contains(curIndex)) {
                                              isoIndexs.remove(curIndex);
                                            }
                                            if (fstopIndexs
                                                .contains(curIndex)) {
                                              fstopIndexs.remove(curIndex);
                                            }
                                            setState(() {});
                                          }
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    ButtonRadio(
                                        onTap: () {
                                          BracketItem item;
                                          try {
                                            item = bracketIndexs.firstWhere(
                                                (element) =>
                                                    element.index == curIndex);

                                            print("item is not null $item");
                                          } catch (e) {
                                            print("item is null");
                                          }

                                          if (item.index !=
                                              getMedian(bracketIndexs).index) {
                                            if (!fstopIndexs
                                                .contains(curIndex)) {
                                              _hdrSequenceBloc.add(
                                                  HdrSequenceEventSwitchFstop());
                                              print("doesnt have fstop");
                                              if (isoIndexs
                                                  .contains(curIndex)) {
                                                isoIndexs.remove(curIndex);
                                              }
                                              if (shutterndexs
                                                  .contains(curIndex)) {
                                                shutterndexs.remove(curIndex);
                                              }
                                              setState(() {
                                                fstopIndexs.add(curIndex);
                                              });
                                            } else {
                                              print("curIndex $curIndex");
                                              if (isoIndexs
                                                  .contains(curIndex)) {
                                                isoIndexs.remove(curIndex);
                                              }
                                              if (shutterndexs
                                                  .contains(curIndex)) {
                                                shutterndexs.remove(curIndex);
                                              }
                                              setState(() {});
                                            }
                                          }
                                        },
                                        isActive:
                                            state is HdrSequenceStateFstop,
                                        bracketColor: "#00FF00",
                                        name: "F-STOP"),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    ButtonRadio(
                                        onTap: () {
                                          BracketItem item;
                                          try {
                                            item = bracketIndexs.firstWhere(
                                                (element) =>
                                                    element.index == curIndex);

                                            print("item is not null $item");
                                          } catch (e) {
                                            print("item is null");
                                          }

                                          if (item.index !=
                                              getMedian(bracketIndexs).index) {
                                            if (!isoIndexs.contains(curIndex)) {
                                              _hdrSequenceBloc.add(
                                                  HdrSequenceEventSwitchIso());
                                              if (shutterndexs
                                                  .contains(curIndex)) {
                                                shutterndexs.remove(curIndex);
                                              }
                                              if (fstopIndexs
                                                  .contains(curIndex)) {
                                                fstopIndexs.remove(curIndex);
                                              }
                                              setState(() {
                                                isoIndexs.add(curIndex);
                                              });
                                            } else {
                                              if (shutterndexs
                                                  .contains(curIndex)) {
                                                shutterndexs.remove(curIndex);
                                              }
                                              if (fstopIndexs
                                                  .contains(curIndex)) {
                                                fstopIndexs.remove(curIndex);
                                              }
                                              setState(() {});
                                            }
                                          }
                                        },
                                        isActive: state is HdrSequenceStateIso,
                                        bracketColor: "#00FFFF",
                                        name: "ISO")
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            BlocBuilder<HdrSequenceBloc, HdrSequenceState>(
                              bloc: _hdrSequenceBloc,
                              builder: (context, state) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "BRACKET ALL SEQUENCE BY | ",
                                    style: latoSemiBold.copyWith(
                                        color: HexColor.fromHex("#3E505B"),
                                        fontSize: 12.sp),
                                  ),
                                  Text(
                                    returnName(state),
                                    style: latoSemiBold.copyWith(
                                        color: HexColor.fromHex("#959FA5"),
                                        fontSize: 12.sp),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              }

              return SizedBox.shrink();
            },
          );
        return SizedBox.shrink();
      },
    );
  }

  BracketItem getMedian(List<BracketItem> values) {
    BracketItem median;

    int middle = values.length ~/ 2;
    if (values.length % 2 == 1) {
      median = values[middle];
    }

    return median;
  }

  int getMedianIndex(List<BracketItem> values) {
    int median;

    int middle = values.length ~/ 2;
    if (values.length % 2 == 1) {
      median = middle;
    }

    return median;
  }

  String returnName(HdrSequenceState state) {
    if (state is HdrSequenceStateIso) {
      return "ISO";
    } else if (state is HdrSequenceStateShutter) {
      return "SHUTTER SPEED";
    } else if (state is HdrSequenceStateFstop) {
      return "FSTOP";
    } else if (state is HdrSequenceStateInitial) {
      return "CUSTOM";
    } else {
      return "Unknown State";
    }
  }
}

class ItemWidget extends StatefulWidget {
  final Sequence curItem;

  ItemWidget({
    @required this.curItem,
  });

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  Sequence get _currentItem => widget.curItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: _currentItem.heigh.h,
              width: _currentItem.width.w,
              child: Align(
                  alignment: Alignment.center,
                  child: VerticalDivider(
                    thickness: _currentItem.width.w,
                    color: HexColor.fromHex("${_currentItem.getColor}"),
                  )),
            ),
            // Container(
            //   height: _currentItem.heigh.h,
            //   width: _currentItem.width.w,
            //   color: HexColor.fromHex("${_currentItem.color}"),
            //   child: Center(
            //     child: Text(
            //       "t",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            Text(
              _currentItem.showName ? getDisplayValue(_currentItem.name) : "",
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: latoSemiBold.copyWith(
                  fontSize: 8.sp, color: HexColor.fromHex("#3E505B")),
            )
          ],
        ),
      ),
    ));
  }
}

String getDisplayValue(double name) {
  return name % 1 == 0
      ? name.toInt().isNegative
          ? "${name.toInt()}"
          : name.toInt() != 0
              ? "+${name.toInt()}"
              : "${name.toInt()}"
      : "$name";
}

class BracketItem {
  int index;
  HdrSequenceState state;
  BracketItem({
    @required this.index,
    @required this.state,
  });

  @override
  String toString() {
    return "index : $index , state : $state";
  }
}
