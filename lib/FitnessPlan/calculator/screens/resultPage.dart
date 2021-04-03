import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/FitnessPlan/calculator/utils/extractedWidgets.dart';
import 'package:lifestyle/FitnessPlan/calculator/utils/textStyles.dart';
import 'package:lifestyle/FitnessPlan/calculator/utils/dynamaicTheme.dart';
import 'package:lifestyle/Health/DietPlan/dietPlan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';

class ResultPage extends StatefulWidget {
  ResultPage({
    @required this.totalCalories,
    @required this.carbs,
    @required this.protein,
    @required this.fats,
    @required this.bmi,
    @required this.tdee,
  });

  final double totalCalories;
  final double carbs;
  final double protein;
  final double fats;
  final double bmi;
  final double tdee;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      value.setDouble("BMI", double.parse(widget.bmi.toStringAsFixed(1)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                //app bar
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 10.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(FontAwesomeIcons.angleLeft),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Hero(
                          tag: "appBarTitle",
                          child: Text(
                            "Results",
                            style: isThemeDark(context) ? TitleTextStyles.dark : TitleTextStyles.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Material(
                        type: MaterialType.transparency,
                        child: Hero(
                          tag: "topContainer",
                          child: MyContainerTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ResultContainer(
                                  title: "Total Calories",
                                  value: "${widget.totalCalories.toStringAsFixed(0)}",
                                  units: " kcals",
                                ),
                                ResultContainer(
                                  title: "Carbs",
                                  value: "${widget.carbs.toStringAsFixed(0)}",
                                  units: " g",
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ResultContainer(
                                        title: "Protein",
                                        value: "${widget.protein.toStringAsFixed(0)}",
                                        units: " g",
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: ResultContainer(
                                        title: "Fats",
                                        value: "${widget.fats.toStringAsFixed(0)}",
                                        units: " g",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Hero(
                        tag: "bottomContainer",
                        child: Material(
                          type: MaterialType.transparency,
                          child: MyContainerTile(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ResultContainer(
                                    title: "BMI",
                                    value: "${widget.bmi.toStringAsFixed(1)}",
                                    units: "",
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: ResultContainer(
                                    title: "TDEE",
                                    value: "${widget.tdee.toStringAsFixed(0)}",
                                    units: " Kcals",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: Card(
                color: Colors.blue,
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => dietPlan(double.parse(widget.bmi.toStringAsFixed(1))))),
                  splashColor: Colors.white,
                  child: Center(
                    child: Text("Check Suggested Diet Plan",
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
