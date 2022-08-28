import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuth {
  Future<UserCredential> signInWithCredential({
    required AuthCredential authCredential,
  });

  Future<void> sendOtp({
    int? forceResendingToken,
    Duration duration = const Duration(minutes: 2),
    required PhoneNumber phoneNumber,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  });

  Future<void> signOut();
}