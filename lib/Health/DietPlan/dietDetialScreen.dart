import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:lifestyle/Health/DietPlan/utils/ColorUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/CommonUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/DimensionUtils.dart';
import 'package:lifestyle/Health/DietPlan/utils/FontUtils.dart';
import 'package:logger/logger.dart';
import 'models/DietPlanData.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:lifestyle/settings.dart';
import 'package:lifestyle/Health/DietPlan/dietPlan.dart';

class dietDetialScreen extends StatefulWidget {
  @override
  _dietDetialScreenState createState() => new _dietDetialScreenState();
}

class _dietDetialScreenState extends State<dietDetialScreen> {
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
    color: ColorUtils.black,
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
    color: ColorUtils.black,
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

  DietPlanData dietPlanData;

  ProgressDialog pr;

  final searchController = TextEditingController();

  initData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      dietPlanData = ModalRoute.of(context).settings.arguments;
    });

    pr = CommonUtils.getProgressDialog(context);
  }

  final logger = Logger();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Widget _proposalPage() {
    return Center(
        child: dietPlanData == null
            ? Text("Loading...")
            : Container(
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(DimensionUtils.margin_large),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: DimensionUtils.margin_large,
                                ),
                                Text(
                                  dietPlanData.title,
                                  style: styleListMediumBold,
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_large,
                                ),
                                Text(
                                  dietPlanData.description,
                                  style: style,
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_large,
                                ),
                                Text(
                                  "HOW IT WORKS",
                                  style: styleListMedium,
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_small,
                                ),
                                Text(
                                  dietPlanData.howtouse,
                                  style: style,
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_large,
                                ),
                                Text(
                                  "FOODS TO CONSUME",
                                  style: styleListMedium,
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_small,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    //DropDown Selection View

                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: DimensionUtils.margin_large,
                                          ),
                                          Container(
                                              child: GestureDetector(
                                                  onTap: () {
//                                          Navigator.pushNamed(
//                                            context,
//                                            RoutesUtils.productViewScreen,
//                                            arguments: ProductScreenArguments(mdata.id,isService,),
//                                          );
                                                  },
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3) -
                                                              DimensionUtils
                                                                  .margin_large,
                                                          height: DimensionUtils
                                                              .img_size_dietplan_item_height,
//                                          color: ColorUtils.black.withOpacity(0.2),
                                                          padding: EdgeInsets.fromLTRB(
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small,
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small),
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    DimensionUtils
                                                                        .margin_large)),
                                                            image:
                                                                new DecorationImage(
                                                              image: new AssetImage(
                                                                  dietPlanData
                                                                      .image1),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "",
                                                            style:
                                                                style.copyWith(
                                                              color: ColorUtils
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ]))),
                                          SizedBox(
                                            height: DimensionUtils.margin_small,
                                          ),
                                          Text(dietPlanData.name1,
                                              style: style.copyWith(
                                                color: ColorUtils.light_black,
                                              )),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: DimensionUtils.margin_large,
                                          ),
                                          Container(
                                              child: GestureDetector(
                                                  onTap: () {
//                                          Navigator.pushNamed(
//                                            context,
//                                            RoutesUtils.productViewScreen,
//                                            arguments: ProductScreenArguments(mdata.id,isService,),
//                                          );
                                                  },
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3) -
                                                              DimensionUtils
                                                                  .margin_large,
                                                          height: DimensionUtils
                                                              .img_size_dietplan_item_height,
//                                          color: ColorUtils.black.withOpacity(0.2),
                                                          padding: EdgeInsets.fromLTRB(
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small,
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small),
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    DimensionUtils
                                                                        .margin_large)),
                                                            image:
                                                                new DecorationImage(
                                                              image: new AssetImage(
                                                                  dietPlanData
                                                                      .image2),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "",
                                                            style:
                                                                style.copyWith(
                                                              color: ColorUtils
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ]))),
                                          SizedBox(
                                            height: DimensionUtils.margin_small,
                                          ),
                                          Text(dietPlanData.name2,
                                              style: style.copyWith(
                                                color: ColorUtils.light_black,
                                              )),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: DimensionUtils.margin_large,
                                          ),
                                          Container(
                                              child: GestureDetector(
                                                  onTap: () {},
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3) -
                                                              DimensionUtils
                                                                  .margin_large,
                                                          height: DimensionUtils
                                                              .img_size_dietplan_item_height,
                                                          padding: EdgeInsets.fromLTRB(
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small,
                                                              DimensionUtils
                                                                  .margin_large,
                                                              DimensionUtils
                                                                  .margin_small),
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    DimensionUtils
                                                                        .margin_large)),
                                                            image:
                                                                new DecorationImage(
                                                              image: new AssetImage(
                                                                  dietPlanData
                                                                      .image3),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "",
                                                            style:
                                                                style.copyWith(
                                                              color: ColorUtils
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ]))),
                                          SizedBox(
                                            height: DimensionUtils.margin_small,
                                          ),
                                          Text(dietPlanData.name3,
                                              style: style.copyWith(
                                                color: ColorUtils.light_black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: DimensionUtils.margin_xxlarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: DimensionUtils.margin_large,
                          ),
                        ],
                      )),
                    )
//          )
                    )));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      isFirst = false;

      initData();
    }

    List<Widget> _widgetOptions = <Widget>[
      _proposalPage(),
      _proposalPage(),
    ];

    return new Scaffold(
        key: _scaffoldKey,
        drawer: SafeArea(
          child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
              ),
              child: Drawer(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(DimensionUtils.margin_xxlarge),
                            bottomRight:
                                Radius.circular(DimensionUtils.margin_xxlarge)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
//                          offset: const Offset(2.0, 2.0),
                            blurRadius: 0.3,
                            spreadRadius: 0.0,
                          ),
                        ]),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          margin: EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[],
                          ),
                        ),
                      ],
                    )),
              )),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(strTitle,
              style: styleAppName.copyWith(color: ColorUtils.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => dietPlan()));
            },
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => settings()));
                    },
                  ),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => mainHome()));
                    },
                  ),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(Icons.supervised_user_circle_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => userAccount()));
                    },
                  )
                ],
              ),
            )));
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
