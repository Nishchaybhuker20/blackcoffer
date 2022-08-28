import 'package:black_coffer/domain/exceptions/value_err.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class OtpCode extends Equatable {
  final String code;

  const OtpCode({
    required this.code,
  });

  bool get validate {
    if (code.isNotEmpty) {
      if (code.length == 6) {
        return true;
      } else {
        throw InvalidValueException(message: "Otp must be 6 digits");
      }
    } else {
      throw InvalidValueException(message: "Otp cannot be empty");
    }
  }

  @override
  List<Object?> get props => [code];
}
