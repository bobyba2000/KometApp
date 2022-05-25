import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? BoxConstraints()
                  : BoxConstraints(maxHeight: 50.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? ConstrainedBox(constraints: BoxConstraints())
          : FlatButton(
              child: const Text('...'),
              onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}

class CollapseWidget extends StatefulWidget {
  @override
  _CollapseWidgetState createState() => _CollapseWidgetState();
}

class _CollapseWidgetState extends State<CollapseWidget>
    with TickerProviderStateMixin {
  GlobalKey _keyFoldChild;
  bool collapsed = false;
  double _childWidth;
  AnimationController _controller;
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _keyFoldChild = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    final RenderBox renderBox = _keyFoldChild.currentContext.findRenderObject();
    _sizeAnimation = Tween<double>(begin: renderBox.size.height, end: 0.0)
        .animate(_controller);
    _childWidth = renderBox.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("data"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  collapsed = !collapsed;
                });
                if (collapsed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
              child: Text("Click me"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: collapsed ? 0 : 100,
                  color: Colors.orange,
                  child: Text("Just some text"),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    if (_sizeAnimation == null) {
                      return child;
                    } else {
                      return ClipRect(
                        child: SizedOverflowBox(
                          size: Size(_childWidth, _sizeAnimation.value),
                          child: child,
                        ),
                      );
                    }
                  },
                  child: Container(
                    key: _keyFoldChild,
                    color: Colors.red,
                    child: Text("Lorem Ipsum Dolar Sit"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
