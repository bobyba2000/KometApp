import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo/src/tester.dart';

class MainTester extends StatefulWidget {
  const MainTester({Key key}) : super(key: key);

  @override
  _MainTesterState createState() => _MainTesterState();
}

class _MainTesterState extends State<MainTester> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(pageControllerListener);
  }

  void selectIndex(int index) {
    if (index == currentIndex) {
      return;
    }
    controller.animateToPage(
      index,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void pageControllerListener() {
    final int currentPage = controller.page?.round();
    if (currentPage != null && currentPage != currentIndex) {
      currentIndex = currentPage;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget header(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 30.0),
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Hero(
              tag: 'LOGO',
              child: Image.asset('assets/images/gallery/city_1.jpg'),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'WeChat Asset Picker',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Unknown version',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          const SizedBox(width: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              header(context),
              Expanded(
                child: PageView(
                  controller: controller,
                  children: <Widget>[
                    MultiAssetsPage(),
                    // SingleAssetPage(),
                    // CustomPickersPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: selectIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_library),
              // ignore: deprecated_member_use
              title: Text('Multi'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              // ignore: deprecated_member_use
              title: Text('Single'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              // ignore: deprecated_member_use
              title: Text('Custom'),
            ),
          ],
        ),
      ),
    );
  }
}
