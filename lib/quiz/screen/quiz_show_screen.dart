import 'dart:async';

import 'package:codexia_learning/quiz/model/quiz_model.dart';
import 'package:codexia_learning/quiz/provider/quiz_provider.dart';
import 'package:codexia_learning/quiz/widget/quiz_timer_widget.dart';
import 'package:codexia_learning/quiz/widget/radio_list_tile_widget.dart';
import 'package:codexia_learning/shared/colour_const.dart';
import 'package:codexia_learning/shared/string_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizShowScreen extends StatefulWidget {
  const QuizShowScreen({required this.chapterId, super.key});

  final String chapterId;

  @override
  State<QuizShowScreen> createState() => _QuizShowScreenState();
}

class _QuizShowScreenState extends State<QuizShowScreen> {
  late QuizProvider quizProvider;
  String selectOption = '';
  bool isOptionSelected = false;
  bool isAnswerCorrect = false;
  var question = 0;

  @override
  void initState() {
    super.initState();
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConst.quizText),
          backgroundColor: ColourConst.green,
        ),
        body: Consumer<QuizProvider>(builder: (create, provider, widgeet) {
          return StreamBuilder(
            stream: quizProvider.quizService.getQuizStream(widget.chapterId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Quiz> quizList = [];
                DataSnapshot dataSnapshot = snapshot.data!.snapshot;
                if (dataSnapshot.exists) {
                  final map = dataSnapshot.value as Map<dynamic, dynamic>;

                    map.forEach((key, value) {
                      var quiz = Quiz(
                        chapterId: value['chapterId'] ?? '',
                        option1: value['option1'] ?? '',
                        option2: value['option2'] ?? '',
                        option3: value['option3'] ?? '',
                        option4: value['option4'] ?? '',
                        correctOption: value['correctOption'] ?? '',
                        question: value['question'] ?? '',
                        questionId: value['questionId'] ?? '',
                    );
                    quizList.add(quiz);
                  });
                }

                return ListView.builder(
                  itemCount: quizList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const QuizTimerWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            RadioListTileWidget(
                              chapterId: widget.chapterId,
                              quizList: quizList,
                              index: index,
                            ),
                          ],
                      ),
                    );
                  },
                );
              }
            },
          );
        },
        ),
      ),
    );
  }
}
