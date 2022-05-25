import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/ui/gallery/gallery_page.dart';

class GallerButton extends StatefulWidget {
  @override
  _GallerButtonState createState() => _GallerButtonState();
}

class _GallerButtonState extends State<GallerButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GalleryPage()));
      },
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      child: SvgPicture.asset(
        isPressed
            ? "assets/icons/Button_Gallery_Pressed.svg"
            : "assets/icons/Button_Gallery_Idle.svg",
        height: 36.h,
        width: 36,
      ),
    );
  }
}
