import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/domain/exceptions/auth_exception.dart';
import 'package:black_coffer/domain/interfaces/i_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends IAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> sendOtp({
    int? forceResendingToken,
    Duration duration = const Duration(minutes: 2),
    required PhoneNumber phoneNumber,
    required PhoneVerificationCompleted phoneVerificationCompleted,
    required PhoneVerificationFailed phoneVerificationFailed,
    required PhoneCodeSent phoneCodeSent,
    required PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      timeout: duration,
      phoneNumber: phoneNumber.phone,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  @override
  Future<UserCredential> signInWithCredential({
    required AuthCredential authCredential,
  }) async {
    try {
      UserCredential _userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      if (_userCredential.user != null) {
        return _userCredential;
      } else {
        throw AuthException(message: "An Unknown Error Occurred");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-verification-code") {
        throw AuthException(message: "Invalid verification code");
      } else if (e.code == "user-disabled") {
        throw AuthException(
            message: "This User is disabled, Please try after sometime");
      } else {
        throw AuthException(message: "Error: ${e.message}");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
