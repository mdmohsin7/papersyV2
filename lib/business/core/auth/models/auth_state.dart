
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final User user;
  final bool isEmailSent;

  AuthState({this.user, this.isEmailSent});

  AuthState copy({User user, bool isEmailSent}) {
    return AuthState(
        user: user ?? this.user, isEmailSent: isEmailSent ?? this.isEmailSent);
  }

  static AuthState initialState() => AuthState(user: null, isEmailSent: false);

  @override
  List<Object> get props => [user, isEmailSent];
}
