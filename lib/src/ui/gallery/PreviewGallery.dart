import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/ui/custom_widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class PreviewGallery extends StatefulWidget {
  final List<Uint8List> imagesState;

  final int index;
  const PreviewGallery({Key key, this.imagesState, this.index})
      : super(key: key);

  @override
  _PreviewGalleryState createState() => _PreviewGalleryState();
}

class _PreviewGalleryState extends State<PreviewGallery> {
  static GlobalKey _globalKey = GlobalKey();
  bool shareLoader;
  bool sharePressed = false;
  int currentItem;

  @override
  void initState() {
    currentItem = widget.index;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
          backgroundColor: HexColor.fromHex("#0E1011"),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: BackCustomUI(
                actionWidget: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  sharePressed = true;
                });
              },
              onTapUp: (details) {
                setState(() {
                  sharePressed = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 6.h, right: 10.w),
                child: SvgPicture.asset(
                  sharePressed
                      ? "assets/icons/Button_Share_Pressed.svg" //mistake name by designer
                      : "assets/icons/Button_Share_Idle.svg",
                  height: 26.h,
                  width: 26.w,
                ),
              ),
              onTap: () {
                Share.share('Share image', subject: 'Share image');
                // shareImage();
              },
            )),
          ),
          body: imageViewer()),
    );
  }

  imageViewer() {
    return LayoutBuilder(builder: (context, constraint) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraint.maxHeight),
        child: IntrinsicHeight(
            child: Column(
          children: [
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                child: InteractiveViewer(
                  scaleEnabled: true,
                  child: Image.memory(
                    widget.imagesState[currentItem],
                    width: double.infinity,
                  ),
                ),
              ),
            )),
            Padding(
              padding:  EdgeInsets.only(bottom: 50.h),
              child: Container(
                height: MediaQuery.of(context).size.height / 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imagesState.length,
                  itemBuilder: (BuildContext c, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 1.0,
                        ),
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: index == currentItem
                                          ? Colors.blueAccent
                                          : HexColor.fromHex("#0E1011"),
                                      width: 4),
                                  color: HexColor.fromHex("#0E1011")),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentItem = index;
                                      });
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.memory(
                                          widget.imagesState[index],
                                          height: 96,
                                          fit: BoxFit.cover,
                                          width: 96,
                                        ))),
                              ),
                            )));
                  },
                ),
              ),
            ),

          ],
        )),
      );
    });
  }
}
