class PostModals {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostModals({this.userId, this.id, this.title, this.body});

  factory PostModals.fromJson(Map<dynamic, dynamic> json) => PostModals(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );

  Map<dynamic, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
