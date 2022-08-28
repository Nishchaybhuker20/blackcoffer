part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SendOtpEvent extends AuthenticationEvent {
  final PhoneNumber phoneNumber;

  const SendOtpEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class ReSendOtpEvent extends AuthenticationEvent {
  final PhoneNumber phoneNumber;

  const ReSendOtpEvent({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthenticationEvent {
  final OtpCode otpCode;
  final String verificationId;

  const VerifyOtpEvent({
    required this.verificationId,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [otpCode, verificationId];
}

class OtpSentEvent extends AuthenticationEvent {
  final String verificationId;
  final PhoneNumber phoneNumber;

  const OtpSentEvent({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        verificationId,
        phoneNumber,
      ];
}

class OtpVerifyingEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class ExceptionEvent extends AuthenticationEvent {
  final AuthException exception;

  const ExceptionEvent({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class PhoneCodeAutoRetrievalTimeoutEvent extends AuthenticationEvent {
  final String verificationId;

  const PhoneCodeAutoRetrievalTimeoutEvent({required this.verificationId});

  @override
  List<Object?> get props => [verificationId];
}

class OtpVerifiedEvent extends AuthenticationEvent {
  final UserCredential userCredential;

  const OtpVerifiedEvent({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}
