import 'package:codexia_learning/chapter/ui/chapter_show_screen.dart';
import 'package:codexia_learning/course/model/course_model.dart';
import 'package:codexia_learning/course/provider/course_provider.dart';
import 'package:codexia_learning/shared/colour_const.dart';
import 'package:codexia_learning/shared/string_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCourseScreen extends StatefulWidget {
  const ShowCourseScreen({super.key});

  @override
  ShowCourseScreenState createState() => ShowCourseScreenState();
}

class ShowCourseScreenState extends State<ShowCourseScreen> {
  late CourseProvider courseProvider;

  @override
  void initState() {
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
         StringConst.course ,
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        backgroundColor: ColourConst.blue,
      ),
      body: Consumer<CourseProvider>(builder: (create, provider, widget) {
        return StreamBuilder(
          stream: provider.courseService.getCourseStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Course> courseList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              final map = dataSnapshot.value as Map<dynamic, dynamic>;

              forEach(map, courseList);
              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    mainAxisExtent: 200,
                  ),
                  itemCount: courseList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ShowChapterScreen(
                              course: courseList[index],
                              courseId: courseList[index].courseId,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        surfaceTintColor: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (courseList[index].imgUrl.isNotEmpty)
                              Image.network(
                                courseList[index].imgUrl,
                                height: 110,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            Text(
                              courseList[index].courseName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        );
      },
      ),
    );
  }

  void forEach(Map<dynamic, dynamic> map, List<Course> courseList) {
    map.forEach((key, value) {
      var course = Course(
        courseId: key,
        courseName: value['courseName'] ?? '',
        imgUrl: value['imgUrl'] ?? '',
      );
      courseList.add(course);
    });
  }
}
