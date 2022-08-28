part of 'phone_form_cubit.dart';

class PhoneFormState extends Equatable {
  final bool hasError;
  final bool hasFocus;
  final String? errorMessage;
  final String? phone;

  const PhoneFormState._({
    required this.phone,
    required this.hasError,
    required this.hasFocus,
    required this.errorMessage,
  });

  factory PhoneFormState.initial() {
    return const PhoneFormState._(
      hasFocus: false,
      errorMessage: null,
      hasError: false,
      phone: null,
    );
  }

  PhoneFormState copyWith({
    String? errorMessage,
    String? phone,
    bool? hasError,
    bool? hasFocus,
  }) {
    return PhoneFormState._(
      hasFocus: hasFocus ?? this.hasFocus,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        hasError,
        hasFocus,
        phone,
      ];
}
