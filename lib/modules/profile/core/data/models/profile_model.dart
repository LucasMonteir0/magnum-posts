import "../../domain/entites/profile_entity.dart";

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.age,
    required super.pictureUrl,
    required super.postsCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      age: json["age"],
      pictureUrl: json["picture_url"],
      postsCount: json["posts_count"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age,
      "picture_url": pictureUrl,
      "posts_count": postsCount,
    };
  }
}
