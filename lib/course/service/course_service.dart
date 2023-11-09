import 'package:firebase_database/firebase_database.dart';

class CourseService {
  final databaseRef = FirebaseDatabase.instance.ref('courses');

  Stream<DatabaseEvent> getCourseStream() {
    return databaseRef.onValue;
  }
}
