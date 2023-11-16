import 'package:codexia_learning/chapter/model/chapter_model.dart';
import 'package:codexia_learning/chapter/provider/chapter_provider.dart';
import 'package:codexia_learning/chapter/ui/chapter_detail_screen.dart';
import 'package:codexia_learning/course/model/course_model.dart';
import 'package:codexia_learning/shared/colour_const.dart';
import 'package:codexia_learning/shared/string_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowChapterScreen extends StatefulWidget {
  final Course course;
final String courseId;
  const ShowChapterScreen({
    required this.course,
    required this.courseId,
    super.key,
  });

  @override
  ShowChapterScreenState createState() => ShowChapterScreenState();
}

class ShowChapterScreenState extends State<ShowChapterScreen> {
  late ChapterProvider chapterProvider;
  @override
  void initState() {
    super.initState();
    chapterProvider = Provider.of<ChapterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConst.chapters,
        ),
        backgroundColor:ColourConst.blue ,
      ),
      body: Consumer<ChapterProvider>(builder: (create, provider, widgeet) {
        return StreamBuilder(
          stream: chapterProvider.chapterService.getChapterStream(widget.courseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Chapter> chapterList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.exists) {
                final map = dataSnapshot.value as Map<String, dynamic>;

                map.forEach((key, value) {
                  var chapter = Chapter(
                    chapterId: value['id'] ?? '',
                    courseId: value['courseId'] ?? '',
                    chapterName: value['chapterName'] ?? '',
                    chapterContent: value['chapterContent'] ?? '',
                  );
                  chapterList.add(chapter);
                });
              }

              return ListView.builder(
                itemCount: chapterList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChapterDetailScreen(
                          chapter: chapterList[index],
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapterList[index].chapterName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      }),
    );
  }
}
