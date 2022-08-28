import 'package:black_coffer/domain/entity/otp_code.dart';
import 'package:black_coffer/domain/exceptions/value_err.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_form_state.dart';

class OtpFormCubit extends Cubit<OtpFormState> {
  OtpFormCubit() : super(OtpFormState.initial());

  void valueChanged(OtpCode otpCode) {
    try {
      if (otpCode.validate) {
        emit(state.copyWith(
          hasError: false,
          otp: otpCode.code,
        ));
      }
    } on InvalidValueException catch (e) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: e.message,
      ));
    }
  }

  void focusedChanged(bool hasFocus) {
    emit(state.copyWith(hasFocus: hasFocus));
  }
}
