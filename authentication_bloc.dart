import 'dart:async';
import 'package:black_coffer/data/repositories/auth_repo.dart';
import 'package:black_coffer/domain/entity/otp_code.dart';
import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/domain/exceptions/auth_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo _authRepo = AuthRepo();
  int? forceResendingToken;

  AuthenticationBloc() : super(AuthInitialState()) {
    on<OtpVerifiedEvent>((event, emit) =>
        emit(OtpVerifiedState(userCredential: event.userCredential)));
    on<SendOtpEvent>((event, emit) async {
      emit(OtpSendingState());
      await sendOtp(
        phoneNumber: event.phoneNumber,
      );
    });
    on<ReSendOtpEvent>((event, emit) async {
      emit(OtpSendingState());
      await sendOtp(
        phoneNumber: event.phoneNumber,
        token: forceResendingToken,
      );
    });

    on<ExceptionEvent>((event, emit) {
      emit(OtpExceptionState(exception: event.exception));
    });

    on<OtpSentEvent>((event, emit) => emit(OtpSentState(
          verificationId: event.verificationId,
          phoneNumber: event.phoneNumber,
        )));
    on<PhoneCodeAutoRetrievalTimeoutEvent>((event, emit) => emit(
        OtpExceptionState(
            exception: AuthException(message: "Otp Code Expired"))));

    on<VerifyOtpEvent>((event, emit) async {
      AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode.code,
      );
      await verifyOtp(authCredential: authCredential);
    });
    on<OtpVerifyingEvent>((event, emit) => emit(OtpVerifyingState()));
  }

  Future<void> sendOtp({
    required PhoneNumber phoneNumber,
    int? token,
  }) async {
    await _authRepo.sendOtp(
        forceResendingToken: token,
        phoneNumber: phoneNumber,
        phoneVerificationCompleted:
            (PhoneAuthCredential _phoneAuthCredential) async =>
                await verifyOtp(authCredential: _phoneAuthCredential),
        phoneVerificationFailed: (FirebaseAuthException firebaseAuthException) {
          add(ExceptionEvent(
              exception: AuthException(message: firebaseAuthException.code)));
        },
        phoneCodeSent: (String verificationId, int? resendingToken) {
          //save token for resend otp
          forceResendingToken = resendingToken;
          add(OtpSentEvent(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ));
        },
        phoneCodeAutoRetrievalTimeout: (String verificationId) {
          add(PhoneCodeAutoRetrievalTimeoutEvent(
              verificationId: verificationId));
        });
  }

  Future<void> verifyOtp({required AuthCredential authCredential}) async {
    add(OtpVerifyingEvent());
    try {
      UserCredential userCredential =
          await _authRepo.signInWithCredential(authCredential: authCredential);
      if (userCredential.user != null) {
        add(OtpVerifiedEvent(userCredential: userCredential));
      } else {
        add(ExceptionEvent(
            exception: AuthException(message: "An Unknown Error Occurred")));
      }
    } on AuthException catch (e) {
      add(ExceptionEvent(exception: e));
    }
  }
}
