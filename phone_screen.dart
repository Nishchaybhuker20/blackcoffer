import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/presentation/authentication/logic/authentication_bloc.dart';
import 'package:black_coffer/presentation/authentication/logic/phone_form_cubit.dart';
import 'package:black_coffer/presentation/authentication/ui/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneFormCubit(),
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, authState) {
            if (authState is OtpExceptionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authState.exception.message)));
            }
            if (authState is OtpSendingState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Sending...")));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.send_to_mobile,
                  size: 150,
                ),
                const PhoneFormField(),
                BlocBuilder<PhoneFormCubit, PhoneFormState>(
                  builder: (context, formState) {
                    return ElevatedButton(
                      onPressed: formState.hasError
                          ? null
                          : () {
                              if (formState.phone != null) {
                                context.read<AuthenticationBloc>().add(
                                      SendOtpEvent(
                                        phoneNumber: PhoneNumber(
                                            phone: formState.phone!),
                                      ),
                                    );
                              }
                            },
                      child: const Text("Send Otp"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
