import 'package:expense_repository/expense_repository.dart';

import '../entities/entities.dart';

class AppUser {
  String email;
  String password;
  String uid;
  DateTime signUpDate;
  DateTime lastLogInDate;

  AppUser({
    required this.email,
    required this.password,
    required this.uid,
    required this.signUpDate,
    required this.lastLogInDate,
  });

  static final empty = AppUser(
    email: '',
    password: '',
    uid: '',
    signUpDate: DateTime.now(),
    lastLogInDate: DateTime.now(),
  );

  AppUserEntity toEntity() {
    return AppUserEntity(
      email: email,
      password: password,
      uid: uid,
      signUpDate: signUpDate,
      lastLogInDate: lastLogInDate,
    );
  }

  static AppUser fromEntity(AppUserEntity entity){
    return AppUser(
      email: entity.email,
      password: entity.password,
      uid: entity.uid,
      signUpDate: entity.signUpDate,
      lastLogInDate: entity.lastLogInDate,
    );
  }
}
