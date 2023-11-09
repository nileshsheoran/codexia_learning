import 'package:firebase_database/firebase_database.dart';

class ChapterService {
  final databaseRef = FirebaseDatabase.instance.ref('courses').child('chapter');

  Stream<DatabaseEvent> getChapterStream(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }
}
