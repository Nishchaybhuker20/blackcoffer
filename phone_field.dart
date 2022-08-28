import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/presentation/authentication/logic/phone_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({Key? key}) : super(key: key);

  @override
  _PhoneFormFieldState createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() => context
        .read<PhoneFormCubit>()
        .focusedChanged(_phoneFocusNode.hasFocus));
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneFormCubit, PhoneFormState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (String value) {
            context
                .read<PhoneFormCubit>()
                .valueChanged(PhoneNumber(phone: value));
          },
          decoration: InputDecoration(
            errorText: state.hasError ? state.errorMessage : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          focusNode: _phoneFocusNode,
        );
      },
    );
  }
}
