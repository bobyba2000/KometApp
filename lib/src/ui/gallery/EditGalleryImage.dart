import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo/res/style/AppImage.dart';
import 'package:neo/src/PickMethod.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/constants/neo_fonts.dart';
import 'package:neo/src/selected_assets_list_view.dart';
import 'package:neo/src/ui/custom_widgets/camera_video/video_camera_scroller.dart';
import 'package:neo/src/ui/custom_widgets/custom_app_bar.dart';
import 'package:neo/src/ui/home/home_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart'
    show
        AssetEntity,
        DefaultAssetPickerProvider,
        DefaultAssetPickerBuilderDelegate;

class EditGalleryImage extends StatefulWidget {
  final List<AssetEntity> assets;

  const EditGalleryImage({Key key, this.assets}) : super(key: key);

  @override
  _EditGalleryImageState createState() => _EditGalleryImageState();
}

class _EditGalleryImageState extends State<EditGalleryImage> {
  final ValueNotifier<bool> isDisplayingDetail = ValueNotifier<bool>(true);

  List<AssetEntity> assets;

  @override
  void initState() {
    assets = widget.assets;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  void dispose() {
    isDisplayingDetail.dispose();
    super.dispose();
  }

  int get assetsLength => assets.length;

  /// These fields are for the keep scroll position feature.
  DefaultAssetPickerProvider keepScrollProvider = DefaultAssetPickerProvider();
  DefaultAssetPickerBuilderDelegate keepScrollDelegate;

  Future<void> selectAssets(PickMethod model) async {
    final List<AssetEntity> result = await model.method(context, assets);
    if (result != null) {
      assets = List<AssetEntity>.from(result);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void removeAsset(int index) {
    assets.removeAt(index);
    if (assets.isEmpty) {
      isDisplayingDetail.value = false;
    }
    setState(() {});
  }

  void onResult(List<AssetEntity> result) {
    if (result != null && result != assets) {
      assets = List<AssetEntity>.from(result);
      if (mounted) {
        setState(() {});
      }
    }
  }

  pickImage() async {
    assets = await AssetPicker.pickAssets(
      context,
      gridCount: 3,
      pageSize: 120,
      maxAssets: 9,
      selectedAssets: assets,
      requestType: RequestType.all,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.neoGray(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(
          isAction: false,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Image.asset(
                            AppImage.flicker5,
                            color: Colors.black.withOpacity(1.0),
                            colorBlendMode: BlendMode.softLight,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Text('Object Boundary Box ...',
                            textAlign: TextAlign.center,
                            style: latoSemiBold.copyWith(
                              fontSize: 20.sp,
                              wordSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFdc143c),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      containerText(
                        boolean: true,
                        text: 'Landscape',
                      ),
                      containerText(boolean: false, text: 'Seascape'),
                      containerText(boolean: true, text: 'Mountain'),
                      containerText(boolean: false, text: 'Waterfall')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      containerText(boolean: false, text: 'Cityscape'),
                      containerText(boolean: true, text: 'Portrait'),
                      containerText(boolean: true, text: 'Undefined')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Will be updated later  ....',
                      textAlign: TextAlign.center,
                      style: latoSemiBold.copyWith(
                        fontSize: 18.sp,
                        wordSpacing: 1.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFdc143c),
                      )),
                  Spacer(),
                  if (assets.isNotEmpty)
                    SelectedAssetsListView(
                      assets: assets,
                      isDisplayingDetail: isDisplayingDetail,
                      onResult: onResult,
                      onRemoveAsset: removeAsset,
                    ),
                  VideoCameraScroller(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: HexColor.fromHex("#0E1011"),
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      height: 84.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BottomBtn(
                            inactiveIcon:
                                "assets/icons/Button_Cancel_Pressed.svg",
                            activeIcon:
                                "assets/icons/Button_Cancel_Pressed.svg",
                          ),
                          BottomBtn(
                            inactiveIcon: "assets/icons/Button_Add_Pressed.svg",
                            activeIcon: "assets/icons/Button_Add_Pressed.svg",
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  containerText({bool boolean, String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blueAccent, width: 1),
          color: !boolean ? HexColor.fromHex("#0E1011") : Colors.blueAccent,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          children: [
            Text(text,
                style: latoSemiBold.copyWith(
                    fontSize: 16.sp,
                    color: boolean
                        ? HexColor.fromHex("#EDEFF0")
                        : Colors.white70)),
          ],
        ),
      ),
    );
  }
}
