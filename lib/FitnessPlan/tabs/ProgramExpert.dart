import 'package:lifestyle/FitnessPlan/components/daily_tip.dart';
import 'package:lifestyle/FitnessPlan/components/header.dart';
import 'package:lifestyle/FitnessPlan/components/image_card_with_basic_footer.dart';
import 'package:lifestyle/FitnessPlan/components/section.dart';
import 'package:lifestyle/FitnessPlan/components/image_card_with_internal.dart';
import 'package:lifestyle/FitnessPlan/components/main_card_programs.dart';
import 'package:lifestyle/FitnessPlan/components/user_photo.dart';
import 'package:lifestyle/FitnessPlan/components/user_tip.dart';
import 'package:lifestyle/FitnessPlan/models/exercise.dart';
import 'package:lifestyle/FitnessPlan/pages/activity_detail.dart';

import 'package:flutter/material.dart';

class ProgramExpert extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      image: 'assets/images/expert_01.jpeg',
      title: 'Easy Start',
      time: '8 min',
      difficult: 'Expert',
      link: 'yplP5cLuyf4', //https://www.youtube.com/watch?v=yplP5cLuyf4&ab_channel=BodyProject
    ),
    Exercise(
      image: 'assets/images/expert_02.jpg',
      title: 'Medium Start',
      time: '16 min',
      difficult: 'Expert',
      link: 'yplP5cLuyf4',
    ),
    Exercise(
      image: 'assets/images/image003.jpg',
      title: 'Pro Start',
      time: '25 min',
      difficult: 'Expert ',
      link: 'yplP5cLuyf4',
    )
  ];

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
    exercises.forEach((exercise) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: ImageCardWithBasicFooter(
            exercise: exercise,
            tag: 'imageHeader$count',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ActivityDetail(
                    exercise: exercise,
                    tag: 'imageHeader$count',
                  );
                },
              ),
            );
          },
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                // Header(
                //   'Exercises',
                //   // rightSide: UserPhoto(),
                // ),
                // MainCardPrograms(), // MainCard
                Section(
                  title: 'Fat burning',
                  horizontalList: this.generateList(context),
                ),
                Section(
                  title: 'Abs Generating',
                  horizontalList: <Widget>[
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image0001.jpg',
                      title: 'Full Body \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image0002.jpg',
                      title: 'Belly \nWorkout',
                      duration: '7 min',
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    children: <Widget>[
                      Section(
                        title: 'Daily Tips',
                        horizontalList: <Widget>[
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                          UserTip(
                            image: 'assets/images/image010.jpg',
                            name: 'User Img',
                          ),
                        ],
                      ),
                      Section(
                        horizontalList: <Widget>[
                          DailyTip(),
                          DailyTip(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
