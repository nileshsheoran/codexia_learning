import 'package:codexia_learning/chapter/model/chapter_model.dart';
import 'package:codexia_learning/chapter/service/chapter_service.dart';
import 'package:codexia_learning/chapter/ui/chapter_detail_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowChapterScreen extends StatefulWidget {
  final ChapterService chapterService;
  final String courseId;

  const ShowChapterScreen({
    required this.chapterService,
    required this.courseId,
    super.key,
  });

  @override
  ShowChapterScreenState createState() => ShowChapterScreenState();
}

class ShowChapterScreenState extends State<ShowChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'chapters',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: widget.chapterService.getChapterStream(widget.courseId),
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
                  id: value['id'] ?? '',
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
                      return ChapterDetailScreen(chapter: chapterList[index]);
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
      ),
    );
  }
}
