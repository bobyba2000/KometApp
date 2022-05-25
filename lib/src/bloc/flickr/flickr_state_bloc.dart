import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';

class FlickrStateBloc extends Bloc<FlickrStateEvent, FlickState> {
  FlickrStateBloc() : super(FlickState());

  @override
  Stream<FlickState> mapEventToState(FlickrStateEvent event) async* {
    if (event is InitFlickrStateEvent) {
      for (String directory in FlickState.directories) {
        this.state.directoriesMap[directory] = [];
        for (int index = 1; index < 30; index++) {
          try {
            ByteData imageData = await rootBundle.load(
                "assets/images/flickr/$directory/${directory}_$index.jpg");
            String json = await rootBundle.loadString(
                "assets/images/flickr/$directory/${directory}_$index.json");

            List<int> bytes = Uint8List.view(imageData.buffer);
            Map jsonDecoded = jsonDecode(json);
            FlickrStateItem item = FlickrStateItem(
              imageBytes: bytes,
              owner: jsonDecoded['Owner'],
              title: jsonDecoded['Title'],
              camera: jsonDecoded['EXIF']['CAMERA'],
              lens: jsonDecoded['EXIF']['LENS'],
              shutter: jsonDecoded['EXIF']['SHUTTER'],
              fstop: jsonDecoded['EXIF']['FSTOP'],
              iso: jsonDecoded['EXIF']['ISO'],
              zoom: jsonDecoded['EXIF']['ZOOM'],
              url: jsonDecoded['URL'],
            );
            // TODO Refactor hot dirty fix for flickr.
            if (index == 1) {
              this.state.directoriesMap[directory].add(item);
            }

            this.state.directoriesMap[directory].add(item);
          } catch (_) {
            break;
          }
        }
      }
    }

    yield this.state;
  }
}

class FlickrStateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitFlickrStateEvent extends FlickrStateEvent {}

class FlickState extends Equatable {
  static List<String> directories = [
    'landscape',
    'seascape',
    'mountain',
    'waterfall',
    'cityscape',
    'portrait',
    'undefined'
  ];

  Map<String, List<FlickrStateItem>> directoriesMap = Map.fromIterable([]);

  FlickState() {
    for (String directory in directories) {
      directoriesMap[directory] = [];
    }
  }

  @override
  List<Object> get props {
    return List.from(directoriesMap.values);
  }
}

class FlickrStateItem {
  List<int> imageBytes;

  String owner;
  String title;
  String camera;
  String lens;
  String shutter;
  String fstop;
  String iso;
  String zoom;
  String url;

  FlickrStateItem(
      {this.imageBytes,
      this.owner,
      this.title,
      this.camera,
      this.lens,
      this.shutter,
      this.fstop,
      this.iso,
      this.zoom,
      this.url});
}
