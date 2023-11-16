class Chapter {
  final String chapterName;
  final String chapterContent;
  final String courseId;
  String? chapterId;

  Chapter(
      {required this.chapterName,
      required this.chapterContent,
      required this.courseId,
      this.chapterId});

  static Chapter fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterName: map['chapterName'],
      chapterContent: map['chapterContent'],
      courseId: map['courseId'],
      chapterId: map['chapterId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chapterName': chapterName,
      'chapterContent': chapterContent,
      'courseId': courseId,
      'chapterId': chapterId,
    };
  }
}
