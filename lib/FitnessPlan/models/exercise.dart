import 'package:flutter/foundation.dart';

class Exercise {
  final String title, time, difficult, image, link;

  Exercise({
    @required this.title,
    @required this.time,
    @required this.difficult,
    @required this.image,
    this.link,
  });
}
