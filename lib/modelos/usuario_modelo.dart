class Usuario {
  String id;
  String name;
  String email;
  String phone;
  String genre;
  String passworld;
  String confirmPassworld;
  bool admin = false;
  
  Usuario(
      {this.phone,
      this.genre,
      this.id,
      this.confirmPassworld,
      this.name,
      this.email,
      this.passworld});
}
