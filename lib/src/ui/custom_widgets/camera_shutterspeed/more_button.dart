import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/ui/custom_widgets/hdr/collapse_button.dart';
import 'package:provider/provider.dart';

class MoreButton extends StatefulWidget {
  @override
  _MoreButtonState createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool isExpande = context.read<ExpandedBloc>().state;
        if (isExpande) {
          context.read<ExpandedBloc>().add(false);
        }
        context
            .read<MoreOptionVisibilityBloc>()
            .add(!context.read<MoreOptionVisibilityBloc>().state);
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
            ? "assets/icons/Button_More_Pressed.svg"
            : "assets/icons/Button_More_Idle.svg",
        height: 36.h,
        width: 36,
      ),
    );
  }
}
