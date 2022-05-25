//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neo/src/utils/FirestoreUtil.dart';
import 'package:stacked/stacked.dart';
import 'package:neo/src/utils/DummyData.dart';

class FlickerViewModel extends BaseViewModel {
  //FireStoreUtil fireStoreUtitlity = FireStoreUtil();
  List<String> imageList = [];
  DummyData dummyData = DummyData();

  // serverAndLocal(String name, int _index) async {
  //   imageList.clear();
  //   setBusy(true);
  //
  //   DocumentSnapshot result = await fireStoreUtitlity.getImageType(type: name);
  //   if (result.exists) {
  //     for (int i = 0; i < result.get('Images').length; i++) {
  //       print(
  //           '/////////////////////////IMAGE FOR $name \n ${result.get('Images')[i]}');
  //       imageList.add(result.get('Images')[i]);
  //     }
  //   } else {
  //     print("NO FIRESTORE OF THAT DOCUMENS");
  //     // Do nothing...
  //   }
  //
  //   if (_index == 0) {
  //     //Lanscape
  //     for (int index = 0;
  //         index < dummyData.landscapeImageList().length;
  //         index++) {
  //       imageList.add(dummyData.landscapeImageList()[index]);
  //     }
  //     setBusy(false);
  //   } else if (_index == 1) {
  //     //Seascape
  //     for (int index = 0;
  //         index < dummyData.seascapeImageList().length;
  //         index++) {
  //       imageList.add(dummyData.seascapeImageList()[index]);
  //     }
  //     // print('**********ALL IMAGES **********');
  //     // for (int index = 0; index < imageList.length; index++) {
  //     //   print("${imageList[index]} \t $index");
  //     // }
  //     setBusy(false);
  //   } else if (_index == 2) {
  //     //Montain
  //     return 0;
  //   } else if (_index == 3) {
  //     //WaterFall
  //     for (int index = 0;
  //         index < dummyData.flickerImageList().length;
  //         index++) {
  //       imageList.add(dummyData.flickerImageList()[index]);
  //     }
  //     setBusy(false);
  //   } else if (_index == 4) {
  //     //CityScape
  //     return 0;
  //   } else if (_index == 5) {
  //     //Portait
  //     return 0;
  //   } else if (_index == 6) {
  //     //Portait
  //     return 0;
  //   }
  //   setBusy(false);
  // }
}
