import 'package:codexia_learning/quiz/model/quiz_model.dart';
import 'package:codexia_learning/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RadioListTileWidget extends StatefulWidget {
  const RadioListTileWidget({
    super.key,
    required this.chapterId,
    required this.quizList,
    required this.index,
  });

  final String chapterId;
  final List<Quiz> quizList;
  final int index;

  @override
  State<RadioListTileWidget> createState() => _RadioListTileWidgetState();
}

class _RadioListTileWidgetState extends State<RadioListTileWidget> {
  late QuizProvider quizProvider;
  String selectOption = '';
  bool isOptionSelected = false;
  bool isAnswerCorrect = false;

  @override
  void initState() {
    super.initState();
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Que.  ${widget.quizList[widget.index].question} of 20',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        RadioListTile<String>(
          title: Text(
            widget.quizList[widget.index].option1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          value: 'A',
          groupValue: selectOption,
          onChanged: (value) {
            if (!isOptionSelected) {
              setState(() {
                selectOption = value!;
                isOptionSelected = true;
                checkAnswer(
                  value!,
                  widget.quizList[widget.index].correctOption,
                );
                quizProvider.dispose();
              });
            }
          },
        ),
        RadioListTile<String>(
          title: Text(
            widget.quizList[widget.index].option2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          value: 'B',
          groupValue: selectOption,
          onChanged: (value) {
            if (!isOptionSelected) {
              setState(() {
                selectOption = value!;
                isOptionSelected = true;
                checkAnswer(
                  value!,
                  widget.quizList[widget.index].correctOption,
                );
                quizProvider.dispose();
              });
            }
          },
        ),
        RadioListTile<String>(
          title: Text(
            widget.quizList[widget.index].option3,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          value: 'C',
          groupValue: selectOption,
          onChanged: (value) {
            if (!isOptionSelected) {
              setState(() {
                selectOption = value!;
                isOptionSelected = true;
                checkAnswer(
                  value!,
                  widget.quizList[widget.index].correctOption,
                );
                quizProvider.dispose();
              });
            }
          },
        ),
        RadioListTile<String>(
          title: Text(
            widget.quizList[widget.index].option4,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          value: 'D',
          groupValue: selectOption,
          onChanged: (value) {
            if (!isOptionSelected) {
              setState(() {
                selectOption = value!;
                isOptionSelected = true;
                checkAnswer(
                  value!,
                  widget.quizList[widget.index].correctOption,
                );
                quizProvider.dispose();
              });
            }
          },
        ),
        if (isOptionSelected)
          Text(
            isAnswerCorrect
                ? 'Your answer is correct!'
                : 'Your answer is incorrect. Correct answer: ${widget.quizList[widget.index].correctOption}',
            style: TextStyle(
              color: isAnswerCorrect ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
      ],
    );
  }

  void checkAnswer(String selected, String correct) {
    setState(() {
      isAnswerCorrect = selected == correct;
    });
  }
}
