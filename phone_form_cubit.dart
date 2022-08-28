import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/domain/exceptions/value_err.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'phone_form_state.dart';

class PhoneFormCubit extends Cubit<PhoneFormState> {
  PhoneFormCubit() : super(PhoneFormState.initial());

  void valueChanged(PhoneNumber phoneNumber) {
    try {
      if (phoneNumber.validate) {
        emit(state.copyWith(hasError: false, phone: phoneNumber.phone,));
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
