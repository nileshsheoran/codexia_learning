import 'package:codexia_learning/chapter/provider/chapter_provider.dart';
import 'package:codexia_learning/chapter/service/chapter_service.dart';
import 'package:codexia_learning/course/provider/course_provider.dart';
import 'package:codexia_learning/course/screen/course_show_screen.dart';
import 'package:codexia_learning/course/service/course_service.dart';
import 'package:codexia_learning/firebase_options.dart';
import 'package:codexia_learning/login/screen/auth_screen.dart';
import 'package:codexia_learning/quiz/provider/quiz_provider.dart';
import 'package:codexia_learning/quiz/service/quiz_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // name: "Codexia"
  );
  const fatalError = true;

  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CourseProvider(CourseService())),
        ChangeNotifierProvider(
            create: (context) => ChapterProvider(ChapterService())),
        ChangeNotifierProvider(
            create: (context) => QuizProvider(QuizService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //TODO for testing only. Replace with AuthScreen later
        // home: const AuthScreen(),
        home: const ShowCourseScreen(),
      ),
    );
  }
}
