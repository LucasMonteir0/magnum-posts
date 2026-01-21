class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final int age;
  final String pictureUrl;
  final int postsCount;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.pictureUrl,
    required this.postsCount,
  });
}
