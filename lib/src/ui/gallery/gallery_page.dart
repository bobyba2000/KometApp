import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:libdsm/libdsm.dart';
import 'package:neo/src/bloc/gallery/gallery_state_bloc.dart';
import 'package:neo/src/ui/custom_widgets/custom_app_bar.dart';
import 'package:neo/src/ui/gallery/PreviewGallery.dart';
import 'package:flutter/services.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  //Dsm dsm = Dsm();
  File ImageFile;
  bool loader = false;
  bool backPressed = false, addPressed = false;

  Future init() async {
    //use your folder name insted of resume.
    // await dsm.init();
    // // await Future.delayed(Duration(seconds: 20));
    // String hostName = await dsm.inverse("192.168.1.106");
    // print("hostName $hostName");
    // int numb = await dsm.login(hostName, "Kali", "madi");
    // print("numb $numb");
    // print("dsmId ${dsm.dsmId}");
    // int treeInt = await dsm.treeConnect("share");
    // print("treeInt $treeInt");
    // dsm.startDiscovery(timeout: 30);

    // dsm.onDiscoveryChanged.listen((event) {
    //   print("onDiscoveryChanged $event");
    // }, onError: (error) {
    //   print("eror on listen $error");
    // });

    // String list = await dsm.getShareList();
    // print("list $list");
    // Socket socket = await Socket.connect("192.168.1.106", 445);

    var message = Uint8List(4);
    var bytedata = ByteData.view(message.buffer);

    bytedata.setUint8(0, 0x01);
    bytedata.setUint8(1, 0x07);
    bytedata.setUint8(2, 0xFF);
    bytedata.setUint8(3, 0x88);
    //
    // socket.listen((event) {
    //   print("event $event");
    // }, onDone: () {
    //   print("OnDone");
    //   socket.close();
    // }, onError: (e) {
    //   print("onError $e");
    //   socket.close();
    // });
    //
    // socket.add(message);
  }

  @override
  void initState() {
    init();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<PagesBloc, PageState>(
    return BlocBuilder<GalleryStateBloc, List<Uint8List>>(
        // builder: (BuildContext context, PageState state) {
        builder: (BuildContext context, List<Uint8List> galleryImagesState) {
      return Scaffold(
        backgroundColor: Color(0xFF0E1011),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: BackCustomUI(
              textValue: '',
              actionWidget: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          addPressed = true;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          addPressed = false;
                        });
                      },
                      child: SvgPicture.asset(
                        addPressed
                            ? "assets/icons/Button_Add_Pressed.svg"
                            : "assets/icons/Button_Add_Idle.svg",
                        height: 36.h,
                        width: 36.w,
                      ),
                      onTap: () {
                        pickImage();
                      },
                    )
                  ],
                ),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: loader == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  itemCount: galleryImagesState.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    //childAspectRatio: 11 / 16
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(
                            galleryImagesState[index],
                            height: 100,
                            fit: BoxFit.cover,
                            width: 100,
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreviewGallery(
                                      index: index,
                                      imagesState: galleryImagesState,
                                    )));
                      },
                    );
                  },
                ),
        ),
      );
    });
  }

  pickImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    final Uint8List bytes = await File(file.path).readAsBytes();
    context.read<GalleryStateBloc>().add(AddImageGalleryStateEvent(bytes));
  }
}
