import 'package:flutter/material.dart';
import 'package:lifestyle/Health/DietPlan/models/DietPlanData.dart';
import 'package:lifestyle/Health/DietPlan/utils/AtkinsData.dart';
import 'package:lifestyle/Health/DietPlan/utils/CleanEatingData.dart';
import 'package:lifestyle/Health/DietPlan/utils/FlexitarianData.dart';
import 'package:lifestyle/Health/DietPlan/utils/KetogenicData.dart';
import 'package:lifestyle/Health/DietPlan/utils/PaleoData.dart';
import 'package:lifestyle/Health/DietPlan/utils/VeganData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:lifestyle/Health/DietPlan/utils/ColorUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/CommonUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/DimensionUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/FontUtils.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/medicalHome.dart';
import 'package:logger/logger.dart';
import 'utils/RoutesUtils.dart';
import 'utils/StrengthFood.dart';

class dietPlan extends StatefulWidget {
  @override
  _dietPlanState createState() => new _dietPlanState();
}

class _dietPlanState extends State<dietPlan> {
  TextStyle styleBottomNavigation = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontWeight: FontWeight.bold,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.primary,
  );

  static TextStyle style = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.black,
  );
  static TextStyle styleGridValue = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.white,
  );

  TextStyle styleAppName = TextStyle(
      fontFamily: FontUtils.FONT_FAMILY_AGEO,
      fontSize: DimensionUtils.txt_size_large,
      fontWeight: FontWeight.bold,
      color: ColorUtils.primary);
  TextStyle styleMedium = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_medium,
    color: ColorUtils.black,
  );
  TextStyle buttonStyle = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_medium,
    color: ColorUtils.white,
  );

  TextStyle styleListMedium = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_medium,
    color: ColorUtils.light_black,
  );
  TextStyle styleListPrice = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.primary,
  );
  TextStyle styleListSmall = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body2,
    color: ColorUtils.light_black,
  );

  TextStyle styleToggleNormal = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    fontWeight: FontWeight.bold,
    color: ColorUtils.light_black,
  );
  TextStyle styleToggleSelected = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    fontWeight: FontWeight.bold,
    color: ColorUtils.primary,
  );

  TextStyle styleListMediumBold = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_medium,
    fontWeight: FontWeight.bold,
    color: ColorUtils.light_black,
  );
  TextStyle styleDrawerMenu = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.light_black,
  );
  TextStyle styleDrawerFooter = TextStyle(
    fontFamily: FontUtils.FONT_FAMILY_AGEO,
    fontSize: DimensionUtils.txt_size_body1,
    color: ColorUtils.red,
  );

  bool isDahboardSelected = false;
  bool isLibrarySelected = false;
  bool isSettingsSelected = false;

  SharedPreferences prefs;
  bool isFirst = true;
  int _selectedIndex = 0;
  String strTitle = "Diet Plans";

  ProgressDialog pr;

  final searchController = TextEditingController();

  initData() async {
    print("_homeScreenState initData................");

    prefs = await SharedPreferences.getInstance();

    pr = CommonUtils.getProgressDialog(context);
  }

  final logger = Logger();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("_homeScreenState dispose................");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      print("_homeScreenState setState................");
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  void goVegan() async {
    Navigator.pushReplacementNamed(
      context,
      RoutesUtils.dietDetialScreen,
      arguments: DietPlanData(
          VeganData.TITLE,
          VeganData.DESC,
          VeganData.HOWTOUSE,
          VeganData.image1,
          VeganData.name1,
          VeganData.image2,
          VeganData.name2,
          VeganData.image3,
          VeganData.name3),
    );
  }

  Widget _proposalPage() {
    return Container(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: GestureDetector(
                            onTap: () {},
                            child: Stack(children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.width),
                                height: DimensionUtils.img_size_dietplan_height,
                                padding: EdgeInsets.fromLTRB(
                                    DimensionUtils.margin_large,
                                    DimensionUtils.margin_small,
                                    DimensionUtils.margin_large,
                                    DimensionUtils.margin_small),
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "images/ic_dietplan.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                  "",
                                  style: style.copyWith(
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: DimensionUtils.img_size_dietplan_height,
                                padding: EdgeInsets.fromLTRB(
                                    DimensionUtils.margin_large,
                                    DimensionUtils.margin_small,
                                    DimensionUtils.margin_large,
                                    DimensionUtils.margin_small),
                                decoration: new BoxDecoration(
//                                              borderRadius: BorderRadius.all(Radius.circular(DimensionUtils.margin_large)),
                                  color: ColorUtils.black.withOpacity(0.2),
                                ),
                              )
                            ]))),

                    SizedBox(
                      height: DimensionUtils.margin_large,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: DimensionUtils.margin_large),
                      child: Text(
                        "BALANCED DIETS",
                        style: style.copyWith(
                            color: ColorUtils.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //DropDown Selection View

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: new DietPlanData(
                                              CleanEatingData.TITLE,
                                              CleanEatingData.DESC,
                                              CleanEatingData.HOWTOUSE,
                                              CleanEatingData.image1,
                                              CleanEatingData.name1,
                                              CleanEatingData.image2,
                                              CleanEatingData.name2,
                                              CleanEatingData.image3,
                                              CleanEatingData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
//
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_cleaneatings.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Clean Eating",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: new DietPlanData(
                                              StrengthFoodData.TITLE,
                                              StrengthFoodData.DESC,
                                              StrengthFoodData.HOWTOUSE,
                                              StrengthFoodData.image1,
                                              StrengthFoodData.name1,
                                              StrengthFoodData.image2,
                                              StrengthFoodData.name2,
                                              StrengthFoodData.image3,
                                              StrengthFoodData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_foodforstrength.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Food for Strength",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        )
                      ],
                    ),

                    //2 Row
                    SizedBox(
                      height: DimensionUtils.margin_large,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: DimensionUtils.margin_large),
                      child: Text(
                        "PLANT - BASED DIETS",
                        style: style.copyWith(
                            color: ColorUtils.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //DropDown Selection View

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        goVegan();
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_vegan.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Vegan",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: DietPlanData(
                                              FlexitarianData.TITLE,
                                              FlexitarianData.DESC,
                                              FlexitarianData.HOWTOUSE,
                                              FlexitarianData.image1,
                                              FlexitarianData.name1,
                                              FlexitarianData.image2,
                                              FlexitarianData.name2,
                                              FlexitarianData.image3,
                                              FlexitarianData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_flexitarian.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Flexitarian",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        )
                      ],
                    ),

                    //3 Row
                    SizedBox(
                      height: DimensionUtils.margin_large,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: DimensionUtils.margin_large),
                      child: Text(
                        "LOW - CARB DIETS",
                        style: style.copyWith(
                            color: ColorUtils.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //DropDown Selection View

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: DietPlanData(
                                              AtkinsData.TITLE,
                                              AtkinsData.DESC,
                                              AtkinsData.HOWTOUSE,
                                              AtkinsData.image1,
                                              AtkinsData.name1,
                                              AtkinsData.image2,
                                              AtkinsData.name2,
                                              AtkinsData.image3,
                                              AtkinsData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_atkins.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Atkins",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        ),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: DietPlanData(
                                              KetogenicData.TITLE,
                                              KetogenicData.DESC,
                                              KetogenicData.HOWTOUSE,
                                              KetogenicData.image1,
                                              KetogenicData.name1,
                                              KetogenicData.image2,
                                              KetogenicData.name2,
                                              KetogenicData.image3,
                                              KetogenicData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_ketogenic.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Ketogenic",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        )
                      ],
                    ),

                    //4th Row
                    SizedBox(
                      height: DimensionUtils.margin_large,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: DimensionUtils.margin_large),
                      child: Text(
                        "THE PALEO DIETS",
                        style: style.copyWith(
                            color: ColorUtils.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //DropDown Selection View

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: DimensionUtils.margin_large,
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: DimensionUtils.margin_large),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutesUtils.dietDetialScreen,
                                          arguments: DietPlanData(
                                              PaleoData.TITLE,
                                              PaleoData.DESC,
                                              PaleoData.HOWTOUSE,
                                              PaleoData.image1,
                                              PaleoData.name1,
                                              PaleoData.image2,
                                              PaleoData.name2,
                                              PaleoData.image3,
                                              PaleoData.name3),
                                        );
                                      },
                                      child: Stack(children: <Widget>[
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "images/ic_paleo.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Text(
                                            "",
                                            style: style.copyWith(
                                              color: ColorUtils.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2) -
                                              DimensionUtils.margin_large,
                                          height: DimensionUtils
                                              .img_size_dietplan_item_height,
                                          padding: EdgeInsets.fromLTRB(
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small,
                                              DimensionUtils.margin_large,
                                              DimensionUtils.margin_small),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(DimensionUtils
                                                    .margin_large)),
                                            color: ColorUtils.black
                                                .withOpacity(0.4),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: DimensionUtils
                                                      .margin_large),
                                              child: Text(
                                                "Paleo",
                                                style: style.copyWith(
                                                  color: ColorUtils.light_white,
                                                ),
                                              )),
                                        )
                                      ]))),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: DimensionUtils.margin_large,
              ),
            ],
          )),
        ));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print("_homeScreenState build................");
    if (isFirst) {
      isFirst = false;
      print("_homeScreenState build isFirst................");
      initData();
    }

    List<Widget> _widgetOptions = <Widget>[
      _proposalPage(),
      _proposalPage(),
    ];

    return new Scaffold(
//      key: _scaffoldKey,
        key: _scaffoldKey,
        // drawer: SafeArea(
        //   child: Theme(
        //       data: Theme.of(context).copyWith(
        //         canvasColor: Colors.transparent,
        //       ),
        //       child: Drawer(
        //         child: Container(
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.only(
        //                     topRight:
        //                         Radius.circular(DimensionUtils.margin_xxlarge),
        //                     bottomRight:
        //                         Radius.circular(DimensionUtils.margin_xxlarge)),
        //                 color: Colors.white,
        //                 boxShadow: [
        //                   BoxShadow(
        //                     blurRadius: 0.3,
        //                     spreadRadius: 0.0,
        //                   ),
        //                 ]),
        //             child: ListView(
        //               padding: EdgeInsets.zero,
        //               children: <Widget>[
        //                 DrawerHeader(
        //                   margin: EdgeInsets.only(bottom: 0.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: <Widget>[],
        //                   ),
        //                 ),
        //               ],
        //             )),
        //       ),
        //       ),
        // ),
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text(strTitle),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => medicalHome()));
          //   },
          // ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //     shape: CircularNotchedRectangle(),
        //     child: Container(
        //       height: 75,
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: <Widget>[
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.settings),
        //             onPressed: () {
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (context) => settings()));
        //             },
        //           ),
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.home),
        //             onPressed: () {
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (context) => mainHome()));
        //             },
        //           ),
        //           IconButton(
        //             iconSize: 50.0,
        //             icon: Icon(Icons.supervised_user_circle_outlined),
        //             onPressed: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => userAccount()));
        //             },
        //           )
        //         ],
        //       ),
        //     )),
            );
  }
}

class HomeSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
}
