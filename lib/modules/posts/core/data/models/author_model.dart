import "../../domain/entities/author_entity.dart";

class AuthorModel extends AuthorEntity {
  const AuthorModel({required super.id, required super.name});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
