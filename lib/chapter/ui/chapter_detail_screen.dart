import 'package:codexia_learning/chapter/model/chapter_model.dart';
import 'package:codexia_learning/chapter/provider/chapter_provider.dart';
import 'package:codexia_learning/quiz/screen/quiz_show_screen.dart';
import 'package:codexia_learning/shared/colour_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChapterDetailScreen extends StatefulWidget {
   const ChapterDetailScreen({required this.chapter,super.key});
 final Chapter chapter;

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  late ChapterProvider chapterProvider;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:ColourConst.deepPurple ,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return QuizShowScreen(chapterId:widget.chapter.chapterId!,);
                }));
              },
              icon: const Icon(Icons.radio_button_on_rounded),
            ),
          ],
        ),
        body: Consumer<ChapterProvider>(builder: (create, provider, context) {
          return Center(
            child: Column(
              children: [
                Text(
                 widget.chapter.chapterName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  widget.chapter.chapterContent,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}