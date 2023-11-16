import 'package:firebase_database/firebase_database.dart';

class QuizService {
  final databaseRef = FirebaseDatabase.instance.ref('chapter').child('quiz');

  Stream<DatabaseEvent> getQuizStream(String chapterId) {
    return FirebaseDatabase.instance.ref('quiz').child(chapterId).onValue;
  }
}
