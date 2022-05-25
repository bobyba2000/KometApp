import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:image/image.dart' as img;
import 'package:neo/src/bloc/mjepg_histo/mjpeg_histo_bloc.dart';
import 'package:neo/src/model/histo_model.dart';

class StreamHelper {
  static const _trigger = 0xFF;
  static const _soi = 0xD8;
  static const _eoi = 0xD9;
  final Client _httpClient = Client();

  StreamSubscription _subscription;
  final MjpegHistoBloc mjpegHistoBloc;

  StreamHelper(this.mjpegHistoBloc);
  Future start(bool isLive, String url) async {
    try {
      await Future.delayed(Duration(seconds: 10));
      final Request request = Request("GET", Uri.parse(url));
      request.headers.addAll(const {});
      final response = await _httpClient.send(request).timeout(Duration(
          minutes:
              1)); //timeout is to prevent process to hang forever in some case
      var count = 0;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var _carry = <int>[];
        _subscription = response.stream.listen((chunk) async {
          count++;
          if (_carry.isNotEmpty && _carry.last == _trigger) {
            if (chunk.first == _eoi) {
              _carry.add(chunk.first);
              await doMargic(Uint8List.fromList(_carry));
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
              if (count >= 20) {
                await doMargic(Uint8List.fromList(_carry));
                count = 0;
                _carry = [];
              }
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
        }, onError: (err) {
          print("error on stream $err");
          dispose();
          mjpegHistoBloc.add(MjpegHistoErrorEvent([], [], [], '$err'));
        }, cancelOnError: true);
      } else {
        print('Stream returned ${response.statusCode} status');
        mjpegHistoBloc.add(MjpegHistoErrorEvent(
            [], [], [], 'Stream returned ${response.statusCode} status'));
        dispose();
      }
    } catch (error) {
      mjpegHistoBloc.add(MjpegHistoErrorEvent([], [], [], '$error'));
      print("error on stream $error");
    }
  }

  Future<void> dispose() async {
    if (_subscription != null) {
      await _subscription.cancel();
      _subscription = null;
    }
    _httpClient.close();
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
