
import 'package:codexia_learning/course/service/course_service.dart';
import 'package:flutter/cupertino.dart';

class CourseProvider extends ChangeNotifier {
   CourseService courseService;

  CourseProvider(this.courseService);
}
