class AppUserEntity {
  String email;
  String password;
  String uid;
  DateTime signUpDate;
  DateTime lastLogInDate;

  AppUserEntity({
    required this.email,
    required this.password,
    required this.uid,
    required this.signUpDate,
    required this.lastLogInDate,
  });
  Map<String, Object?> toDocument() {
    return {
      'email': email,
      'password': password,
      'uid': uid,
      'signUpDate': signUpDate,
      'lastLogInDate': lastLogInDate,
    };
  }

  static AppUserEntity fromDocument(Map<String, dynamic> doc) {
    return AppUserEntity(
      email: doc["email"],
      password: doc["password"],
      uid: doc["uid"],
      signUpDate: doc["signUpDate"],
      lastLogInDate: doc["lastLogInDate"],
    );
  }
}
