import 'package:black_coffer/domain/exceptions/value_err.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class PhoneNumber extends Equatable {
  final String phone;

  const PhoneNumber({
    required this.phone,
  });

  bool get validate {
    if (phone.isNotEmpty) {
      if (phone.length == 14) {
        return true;
      } else {
        throw InvalidValueException(
            message: "Length must be 10 without Country-code");
      }
    } else {
      throw InvalidValueException(message: "Phone can't be Empty");
    }
  }

  @override
  List<Object?> get props => [phone];
}
