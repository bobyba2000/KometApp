import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/utils/DummyData.dart';

class GalleryStateBloc extends Bloc<GalleryStateEvent, List<Uint8List>> {
  GalleryStateBloc() : super([]);
  @override
  Stream<List<Uint8List>> mapEventToState(GalleryStateEvent event) async* {
    if (event is InitGalleryStateEvent) {
      List<String> localGalleryList = DummyData().localGalleryList();

      for (int index = 0; index < localGalleryList.length; index++) {
        // Copy init images to
        ByteData imageData = await rootBundle.load(localGalleryList[index]);
        List<int> bytes = Uint8List.view(imageData.buffer);
        // imageData.
        this.state.add(bytes);
      }
    }
    if (event is AddImageGalleryStateEvent) {
      this.state.insert(0, event.imageBytes);
    }

    yield List.from(this.state);
    // rootBundle.loadStructuredData(key, (value) => null)

    // String directory = (await getApplicationDocumentsDirectory()).path;

    // List<FileSystemEntity> file = io.Directory("$directory/resume/")
    //     .listSync();
  }
}

class GalleryStateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitGalleryStateEvent extends GalleryStateEvent {}

class AddImageGalleryStateEvent extends GalleryStateEvent {
  Uint8List imageBytes;

  AddImageGalleryStateEvent(this.imageBytes);
}
