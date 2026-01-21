import "../../domain/entities/post_entity.dart";

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body, "userId": userId};
  }
}
