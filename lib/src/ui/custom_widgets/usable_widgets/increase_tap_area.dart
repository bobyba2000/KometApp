import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExpandedHitTestArea extends SingleChildRenderObjectWidget {
  const ExpandedHitTestArea({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderExpandedHitTestArea();
}

class RenderExpandedHitTestArea extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  // trivial implementations left out to save space: computeMinIntrinsicWidth, computeMaxIntrinsicWidth, computeMinIntrinsicHeight, computeMaxIntrinsicHeight

  @override
  void performLayout() {
    child.layout(constraints, parentUsesSize: true);
    size = child.size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final BoxParentData childParentData = child.parentData;
      context.paintChild(child, childParentData.offset + offset);
    }
  }

  @override
  bool hitTest(HitTestResult result, {Offset position}) {
    const minimalSize = 44;
    final deltaX = (minimalSize - size.width).clamp(0, double.infinity) / 2;
    final deltaY = (minimalSize - size.height).clamp(0, double.infinity) / 2;
    if (Rect.fromLTRB(
            -deltaX, -deltaY, size.width + deltaX, size.height + deltaY)
        .contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
