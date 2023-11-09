import 'package:codexia_learning/quiz/model/quiz_model.dart';
import 'package:codexia_learning/quiz/service/quiz_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class QuizShowScreen extends StatefulWidget {
  final QuizService quizService;

  final String chapterId;

  const QuizShowScreen(
      {required this.quizService, required this.chapterId, super.key});

  @override
  State<QuizShowScreen> createState() => _QuizShowScreenState();
}

class _QuizShowScreenState extends State<QuizShowScreen> {
  List<String> selectedOption = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Show'),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
          stream: widget.quizService.getChapterStream(widget.chapterId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Quiz> quizList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.exists) {
                final map = dataSnapshot.value as Map<String, dynamic>;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Que.  ${quizList[index].question}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        RadioListTile<String>(
                          title: Text(
                            quizList[index].option1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: 'A',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(
                            quizList[index].option2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: 'B',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(
                            quizList[index].option3,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: 'C',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(
                            quizList[index].option4,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          value: 'D',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        Text(
                          'Correct Answer: ${quizList[index].correctOption}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
