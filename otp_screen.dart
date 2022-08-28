import 'package:black_coffer/domain/entity/otp_code.dart';
import 'package:black_coffer/domain/entity/phone_number.dart';
import 'package:black_coffer/presentation/authentication/logic/authentication_bloc.dart';
import 'package:black_coffer/presentation/authentication/logic/otp_form_cubit.dart';
import 'package:black_coffer/presentation/authentication/ui/widgets/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  final PhoneNumber phoneNumber;

  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpFormCubit(),
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, authState) {
            if (authState is OtpVerifyingState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Verifying...")));
            }
            if (authState is OtpExceptionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authState.exception.message)));
            }
            if (authState is OtpVerifyingState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text("Verified")));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(
                        onPressed: () {
                          //TODO: context.read<AuthenticationBloc>().add();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.message,
                        size: 150,
                      ),
                      const OtpFormField(),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(ReSendOtpEvent(phoneNumber: phoneNumber));
                        },
                        child: const Text("Did not get Otp, Resend?"),
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, authState) {
                          return BlocBuilder<OtpFormCubit, OtpFormState>(
                            builder: (context, formState) {
                              return ElevatedButton(
                                onPressed: formState.hasError
                                    ? null
                                    : () {
                                        if (authState is OtpSentState) {
                                          if (formState.otp != null) {
                                            context
                                                .read<AuthenticationBloc>()
                                                .add(
                                                  VerifyOtpEvent(
                                                    verificationId: authState
                                                        .verificationId,
                                                    otpCode: OtpCode(
                                                        code: formState.otp!),
                                                  ),
                                                );
                                          }
                                        }
                                      },
                                child: const Text("Get Started"),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
