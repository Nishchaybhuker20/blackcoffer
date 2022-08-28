import 'package:black_coffer/core/app_bloc.dart';
import 'package:black_coffer/presentation/authentication/logic/authentication_bloc.dart';
import 'package:black_coffer/presentation/authentication/ui/otp_screen.dart';
import 'package:black_coffer/presentation/authentication/ui/phone_screen.dart';
import 'package:black_coffer/presentation/home/ui/home_screen.dart';
import 'package:black_coffer/presentation/upload/logic/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => UploadBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<UploadBloc, UploadState>(
          listener: (context, uploadState) {
            if (uploadState is UploadedState) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text("Upload Completed")));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
              return BlocBuilder<AppBloc, AppState>(
                builder: (context, appState) {
                  if (appState is AuthenticatedState) {
                    return const HomeScreen();
                  }
                  return Builder(builder: (context) {
                    if (authState is OtpSentState) {
                      return OtpScreen(
                        phoneNumber: authState.phoneNumber,
                      );
                    }
                    return const PhoneScreen();
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
