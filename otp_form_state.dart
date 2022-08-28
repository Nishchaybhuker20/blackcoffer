part of 'otp_form_cubit.dart';

class OtpFormState extends Equatable {
  final bool hasError;
  final String? errorMessage;
  final String? otp;
  final bool hasFocus;

  const OtpFormState._({
    required this.hasError,
    required this.errorMessage,
    required this.hasFocus,
    required this.otp,
  });

  factory OtpFormState.initial() {
    return const OtpFormState._(
      errorMessage: null,
      hasError: false,
      hasFocus: false,
      otp: null,
    );
  }

  OtpFormState copyWith({
    String? errorMessage,
    bool? hasError,
    bool? hasFocus,
    String? otp,
  }) {
    return OtpFormState._(
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      hasFocus: hasFocus ?? this.hasFocus,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        hasError,
        hasFocus,
        otp,
      ];
}
