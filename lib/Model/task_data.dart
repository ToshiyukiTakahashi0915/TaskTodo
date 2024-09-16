class TaskData {
  final String? id;
  final String title;
  final String date;
  final String body;

  TaskData({
    this.id,
    required this.title,
    required this.date,
    required this.body,
  });

  // Firestore からデータを取得する際に Map から Task を生成する
  factory TaskData.fromMap(Map<String, dynamic> map, String documentId) {
    return TaskData(
      id: documentId,
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      body: map['body'] ?? '',
    );
  }
// Firestore に保存するデータ (Map) を生成する
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'body': body,
    };
  }

  TaskData copyWith({String? id, String? title, String? date, String? body}) {
    return TaskData(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      body: body ?? this.body,
    );
  }
}