import 'package:black_coffer/domain/entity/otp_code.dart';
import 'package:black_coffer/presentation/authentication/logic/otp_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpFormField extends StatefulWidget {
  const OtpFormField({Key? key}) : super(key: key);

  @override
  _OtpFormFieldState createState() => _OtpFormFieldState();
}

class _OtpFormFieldState extends State<OtpFormField> {
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _otpFocusNode.addListener(() =>
        context.read<OtpFormCubit>().focusedChanged(_otpFocusNode.hasFocus));
  }

  @override
  void dispose() {
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpFormCubit, OtpFormState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (String value) {
            context
                .read<OtpFormCubit>()
                .valueChanged(OtpCode(code: value));
          },
          decoration: InputDecoration(
            errorText: state.hasError ? state.errorMessage : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          focusNode: _otpFocusNode,
        );
      },
    );
  }
}
