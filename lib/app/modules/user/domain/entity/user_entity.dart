class UserEntity {
  UserEntity({
    this.name,
    this.email,
    this.imageUrl,
    this.authenticated = false,
  });

  String? name;
  String? imageUrl;
  String? email;
  bool authenticated;
}
