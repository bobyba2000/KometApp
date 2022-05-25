import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo/src/ui/gallery/FlickrScreen.dart';

class FlickrButton extends StatefulWidget {
  @override
  _FlickrButtonState createState() => _FlickrButtonState();
}

class _FlickrButtonState extends State<FlickrButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FlickrScreen()));
      },
      child: Container(
        child: SvgPicture.asset(
          isPressed
              ? "assets/icons/Button_Exif_Pressed.svg"
              : "assets/icons/Button_Exif_Idle.svg",
          height: 36,
          width: 36,
        ),
      ),
    );
  }
}
