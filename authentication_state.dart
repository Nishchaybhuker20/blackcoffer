part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthInitialState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class OtpSendingState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class OtpSentState extends AuthenticationState {
  final String verificationId;
  final PhoneNumber phoneNumber;

  const OtpSentState({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [
        verificationId,
        phoneNumber,
      ];
}

class OtpVerifyingState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends AuthenticationState {
  final UserCredential userCredential;

  const OtpVerifiedState({required this.userCredential});

  @override
  List<Object> get props => [userCredential];
}

class OtpExceptionState extends AuthenticationState {
  final AuthException exception;

  const OtpExceptionState({required this.exception});

  @override
  List<Object> get props => [exception];
}
