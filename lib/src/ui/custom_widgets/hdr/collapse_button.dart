import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/src/bloc/more_option/more_option_visibility_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';

import 'expanded_items/scroller_sequence.dart';

class CollapsibleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandedBloc, bool>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: IconButton(
              onPressed: () {
                bool isMore = context.read<MoreOptionVisibilityBloc>().state;
                if (isMore) {
                  context.read<MoreOptionVisibilityBloc>().add(false);
                }
                context.read<ExpandedBloc>().add(!state);
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ADVANCED",
                    style: latoSemiBold.copyWith(
                        color: HexColor.fromHex("#3E505B")),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  CollapseButton(
                    isCollapsed: state,
                  ),
                ],
              ),
            ))
          ],
        );
      },
    );
  }
}

class CollapseButton extends StatefulWidget {
  final bool isCollapsed;

  const CollapseButton({Key key, @required this.isCollapsed}) : super(key: key);
  @override
  _CollapseButtonState createState() => _CollapseButtonState();
}

class _CollapseButtonState extends State<CollapseButton> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      widget.isCollapsed
          ? "assets/icons/Icon_Expand.svg"
          : "assets/icons/Icon_Collapse.svg",
      width: 12.w,
      height: 12.h,
    );
  }
}

class ExpandedBloc extends Bloc<bool, bool> {
  ExpandedBloc() : super(false);

  @override
  Stream<bool> mapEventToState(bool event) async* {
    yield event;
  }
}
