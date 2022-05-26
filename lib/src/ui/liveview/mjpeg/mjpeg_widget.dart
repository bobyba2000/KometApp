import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:image/image.dart' as img;
import 'package:neo/src/bloc/mjepg_histo/mjpeg_histo_bloc.dart';
import 'package:neo/src/model/histo_model.dart';

// // class _MjpegStateNotifier extends ChangeNotifier {
// //   bool _mounted = true;
// //   bool _visible = true;

// //   _MjpegStateNotifier() : super();

// //   bool get mounted => _mounted;

// //   bool get visible => _visible;

// //   set visible(value) {
// //     _visible = value;
// //     notifyListeners();
// //   }

// //   @override
// //   void dispose() {
// //     _mounted = false;
// //     notifyListeners();
// //     super.dispose();
// //   }
// // }

// /// A Mjpeg.
// class MjpegWidget extends HookWidget {
//   final String stream;
//   final BoxFit fit;
//   final double width;
//   final double height;
//   final bool isLive;
//   final Duration timeout;
//   final WidgetBuilder loading;
//   final Widget Function(BuildContext contet, dynamic error) error;
//   final Map<String, String> headers;

//   const MjpegWidget({
//     this.isLive = false,
//     this.width,
//     this.timeout = const Duration(seconds: 10),
//     this.height,
//     this.fit,
//     @required this.stream,
//     this.error,
//     this.loading,
//     this.headers = const {},
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final image = useState<MemoryImage>(null);
//     final state = useMemoized(() => _MjpegStateNotifier());
//     final visible = useListenable(state);
//     final errorState = useState<dynamic>(null);
//     final manager = useMemoized(
//         () =>
//             _StreamManager(stream, isLive && visible.visible, headers, timeout),
//         [stream, isLive, visible.visible, timeout]);
//     final key = useMemoized(() => UniqueKey(), [manager]);

//     useEffect(() {
//       errorState.value = null;
//       manager.updateStream(context, image, errorState);
//       return manager.dispose;
//     }, [manager]);

//     return FutureBuilder(
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (errorState.value != null) {
//           return SizedBox(
//             width: width,
//             height: height,
//             child: error == null
//                 ? Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         '${errorState.value}',
//                         textAlign: TextAlign.center,
//                         softWrap: true,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   )
//                 : error(context, errorState.value),
//           );
//         }

//         if (image.value == null) {
//           return SizedBox(
//               width: width,
//               height: height,
//               child: loading == null
//                   ? Center(child: CircularProgressIndicator())
//                   : loading(context));
//         }

//         return VisibilityDetector(
//           key: key,
//           child: Image(
//             image: image.value,
//             width: width,
//             height: height,
//             fit: fit,
//           ),
//           onVisibilityChanged: (VisibilityInfo info) {
//             if (visible.mounted) {
//               visible.visible = info.visibleFraction != 0;
//             }
//           },
//         );
//         return Mjpeg(
//           stream: stream,
//           isLive: isLive && visible.visible,
//           timeout: timeout,
//           error: (context, error, stack) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   error.toString(),
//                   textAlign: TextAlign.center,
//                   softWrap: true,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             );
//           },
//           loading: (context) => Center(child: CircularProgressIndicator()),
//           width: width,
//           height: height,
//         );
//       },
//       future: Future.delayed(Duration(seconds: 3)),
//     );
//   }
// }

// class _StreamManager {
//   static const _trigger = 0xFF;
//   static const _soi = 0xD8;
//   static const _eoi = 0xD9;

//   final String stream;
//   final bool isLive;
//   final Duration _timeout;
//   final Map<String, String> headers;
//   final Client _httpClient = Client();
//   StreamSubscription _subscription;

//   _StreamManager(this.stream, this.isLive, this.headers, this._timeout);

//   Future<void> dispose() async {
//     if (_subscription != null) {
//       await _subscription.cancel();
//       _subscription = null;
//     }
//     _httpClient.close();
//   }

//   Future<void> _sendImage(
//       BuildContext context,
//       ValueNotifier<MemoryImage> image,
//       ValueNotifier<dynamic> errorState,
//       List<int> chunks) async {
//     final MemoryImage imageMemory = MemoryImage(Uint8List.fromList(chunks));
//     try {
//       await precacheImage(imageMemory, context, onError: (err, trace) {
//         print(err);
//       });
//       errorState.value = null;
//       image.value = imageMemory;
//     } catch (ex) {}

//     // compute(doMargic, Uint8List.fromList(chunks));
//   }

//   void updateStream(BuildContext context, ValueNotifier<MemoryImage> image,
//       ValueNotifier<dynamic> errorState) async {
//     try {
//       final request = Request("GET", Uri.parse(stream));
//       request.headers.addAll(headers);
//       final response = await _httpClient.send(request).timeout(
//           _timeout); //timeout is to prevent process to hang forever in some case

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         var _carry = <int>[];
//         _subscription = response.stream.listen((chunk) async {
//           if (_carry.isNotEmpty && _carry.last == _trigger) {
//             if (chunk.first == _eoi) {
//               _carry.add(chunk.first);
//               await _sendImage(context, image, errorState, _carry);
//               _carry = [];
//               if (!isLive) {
//                 dispose();
//               }
//             }
//           }

//           for (var i = 0; i < chunk.length - 1; i++) {
//             final d = chunk[i];
//             final d1 = chunk[i + 1];

//             if (d == _trigger && d1 == _soi) {
//               _carry.add(d);
//             } else if (d == _trigger && d1 == _eoi && _carry.isNotEmpty) {
//               _carry.add(d);
//               _carry.add(d1);

//               await _sendImage(context, image, errorState, _carry);
//               _carry = [];
//               if (!isLive) {
//                 dispose();
//               }
//             } else if (_carry.isNotEmpty) {
//               _carry.add(d);
//               if (i == chunk.length - 2) {
//                 _carry.add(d1);
//               }
//             }
//           }
//         }, onError: (err) {
//           try {
//             errorState.value = err;
//             image.value = null;
//           } catch (ex) {}
//           dispose();
//         }, cancelOnError: true);
//       } else {
//         errorState.value =
//             HttpException('Stream returned ${response.statusCode} status');
//         image.value = null;
//         dispose();
//       }
//     } catch (error) {
//       errorState.value = error;
//       image.value = null;
//     }
//   }
// }

// class ColorInt {
//   static int red(int color) {
//     return (color >> 16) & 0xFF;
//   }

//   static int green(int color) {
//     return (color >> 8) & 0xFF;
//   }

//   static int blue(int color) {
//     return color & 0xFF;
//   }
// }

class _MjpegStateNotifier extends ChangeNotifier {
  bool _mounted = true;
  bool _visible = true;

  _MjpegStateNotifier() : super();

  bool get mounted => _mounted;

  bool get visible => _visible;

  set visible(value) {
    _visible = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    notifyListeners();
    super.dispose();
  }
}

/// A Mjpeg.
class MjpegWidget extends HookWidget {
  final String stream;
  final BoxFit fit;
  final double width;
  final double height;
  final bool isLive;
  final Duration timeout;
  final WidgetBuilder loading;
  final MjpegHistoBloc mjpegHistoBloc;
  final Widget Function(BuildContext contet, dynamic error, dynamic stack)
      error;
  final Map<String, String> headers;
  final Function onTryAgain;

  const MjpegWidget({
    this.isLive = false,
    this.width,
    this.timeout = const Duration(seconds: 10),
    this.height,
    this.fit,
    @required this.stream,
    this.error,
    this.loading,
    @required this.mjpegHistoBloc,
    this.headers = const {},
    this.onTryAgain,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = useState<MemoryImage>(null);
    final state = useMemoized(() => _MjpegStateNotifier());
    final visible = useListenable(state);
    final errorState = useState<List<dynamic>>(null);
    final manager = useMemoized(
        () => _StreamManager(
              stream,
              isLive && visible.visible,
              headers,
              timeout,
              mjpegHistoBloc,
            ),
        [stream, isLive, visible.visible, timeout]);
    final key = useMemoized(() => UniqueKey(), [manager]);

    useEffect(() {
      errorState.value = null;
      manager.updateStream(context, image, errorState);
      return manager.dispose;
    }, [manager]);

    if (errorState.value != null) {
      // onTryAgain.call();
      // return SizedBox(
      //     width: width,
      //     height: height,
      //     child: loading == null
      //         ? Center(child: CircularProgressIndicator())
      //         : loading(context));
      return SizedBox(
        width: width,
        height: height,
        child: error == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${errorState.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            : error(context, errorState.value.first, errorState.value.last),
      );
    }

    if (image.value == null) {
      return SizedBox(
          width: width,
          height: height,
          child: loading == null
              ? Center(child: CircularProgressIndicator())
              : loading(context));
    }

    return VisibilityDetector(
      key: key,
      child: Image(
        image: image.value,
        width: width,
        height: height,
        gaplessPlayback: true,
        fit: fit,
      ),
      onVisibilityChanged: (VisibilityInfo info) {
        if (visible.mounted) {
          visible.visible = info.visibleFraction != 0;
        }
      },
    );
  }
}

class _StreamManager {
  static const _trigger = 0xFF;
  static const _soi = 0xD8;
  static const _eoi = 0xD9;

  final String stream;
  final bool isLive;
  final Duration _timeout;
  final Map<String, String> headers;
  final Client _httpClient = Client();
  final MjpegHistoBloc mjpegHistoBloc;
  // ignore: cancel_subscriptions
  StreamSubscription _subscription;

  _StreamManager(
    this.stream,
    this.isLive,
    this.headers,
    this._timeout,
    this.mjpegHistoBloc,
  );

  Future<void> dispose() async {
    if (_subscription != null) {
      await _subscription.cancel();
      _subscription = null;
    }
    _httpClient.close();
  }

  void _sendImage(BuildContext context, ValueNotifier<MemoryImage> image,
      ValueNotifier<dynamic> errorState, List<int> chunks) async {
    final imageMemory = MemoryImage(Uint8List.fromList(chunks));
    errorState.value = null;
    image.value = imageMemory;
  }

  void updateStream(BuildContext context, ValueNotifier<MemoryImage> image,
      ValueNotifier<List<dynamic>> errorState) async {
    try {
      print('send REquest');
      final request = Request("GET", Uri.parse(stream));
      request.headers.addAll(headers);
      final response = await _httpClient.send(request).timeout(
          _timeout); //timeout is to prevent process to hang forever in some case

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var _carry = <int>[];
        int count = 0;
        _subscription = response.stream.listen((chunk) async {
          count++;
          if (_carry.isNotEmpty && _carry.last == _trigger) {
            if (chunk.first == _eoi) {
              _carry.add(chunk.first);
              _sendImage(context, image, errorState, _carry);
              _carry = [];
              if (!isLive) {
                dispose();
              }
            }
          }

          for (var i = 0; i < chunk.length - 1; i++) {
            final d = chunk[i];
            final d1 = chunk[i + 1];

            if (d == _trigger && d1 == _soi) {
              _carry.add(d);
            } else if (d == _trigger && d1 == _eoi && _carry.isNotEmpty) {
              _carry.add(d);
              _carry.add(d1);

              _sendImage(context, image, errorState, _carry);
              if (count >= 20) {
                doMargic(Uint8List.fromList(_carry));
                count = 0;
              }
              _carry = [];
              if (!isLive) {
                dispose();
              }
            } else if (_carry.isNotEmpty) {
              _carry.add(d);
              if (i == chunk.length - 2) {
                _carry.add(d1);
              }
            }
          }
        }, onError: (error, stack) {
          try {
            errorState.value = [error, stack];
            image.value = null;
          } catch (ex) {}
          dispose();
        }, cancelOnError: true);
      } else {
        errorState.value = [
          HttpException('Stream returned ${response.statusCode} status'),
          StackTrace.current
        ];
        image.value = null;
        dispose();
      }
    } catch (error, stack) {
      // we ignore those errors in case play/pause is triggers
      if (!error
          .toString()
          .contains('Connection closed before full header was received')) {
        errorState.value = [error, stack];
        image.value = null;
      }
    }
  }

  Future doMargic(Uint8List listUI) async {
    try {
      Stopwatch stopwatch = new Stopwatch()..start();
      List<int> redColorBins = List<int>.filled(257, 0);
      List<int> greenColorBins = List<int>.filled(257, 0);
      List<int> blueColorBins = List<int>.filled(257, 0);

      img.Image imgME = img.decodeImage(listUI);
      var listImage = imgME.getBytes();
      if (listImage != null) {
        for (int x = 0; x < imgME.width; x++) {
          for (int y = 0; y < imgME.height; y++) {
            int pixel = imgME.getPixel(x, y);
            redColorBins[ColorInt.red(pixel)]++;
            // print("redColorBins ${ColorInt.red(pixel)}");
            greenColorBins[ColorInt.green(pixel)]++;
            blueColorBins[ColorInt.blue(pixel)]++;
          }
        }
        redColorBins = normilize(redColorBins);
        greenColorBins = normilize(greenColorBins);
        blueColorBins = normilize(blueColorBins);
        List<HistoModel> redBins = [];
        List<HistoModel> greenBins = [];
        List<HistoModel> blueBins = [];

        for (int i = 0; i < 256; i++) {
          redBins.add(HistoModel(yValue: redColorBins[i], xValue: i));
          greenBins.add(HistoModel(yValue: greenColorBins[i], xValue: i));
          blueBins.add(HistoModel(yValue: blueColorBins[i], xValue: i));
        }

        mjpegHistoBloc.add(MjPegHistoEventAdd(redBins, greenBins, blueBins));

        //  loaded = true;
      } else {
        //  loaded = false;
      }
      //print( 'computeColorBins() executed in ${stopwatch.elapsed.inMilliseconds}');
      // print("ok");
    } catch (e) {
      print("error do magic $e");
    }
  }

  List<int> normilize(
    List<int> bins,
  ) {
    List<int> normalized = List.filled(bins.length, 0);
    int max = bins.reduce((curr, next) => curr > next ? curr : next);
    int min = bins.reduce((curr, next) => curr < next ? curr : next);
    for (int i = 0; i < normalized.length; i++) {
      normalized[i] = norm(bins[i], min, max, 255, 0);
    }
    return normalized;
  }

  norm(int v, int min, int max, int newMax, int newMin) {
    return ((v - min) * (newMax - newMin).ceilToDouble() / (max - min) + newMin)
        .ceil();
  }
}

class ColorInt {
  static int red(int color) {
    return ((color - 255 * 256 * 256 * 256) / (256 * 256)).ceil();
  }

  static int green(int color) {
    int rgb = color - 255 * 256 * 256 * 256;
    int gb = rgb % (256 * 256);

    return (gb / 256).ceil();
  }

  static int blue(int color) {
    int rgb = color - 255 * 256 * 256 * 256;
    int gb = rgb % (256 * 256);
    return gb % 256;
  }
}
