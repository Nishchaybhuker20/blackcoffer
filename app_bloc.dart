import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final StreamSubscription _streamSubscription;

  AppBloc() : super(UnAuthenticatedState()) {
    _streamSubscription = FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        add(AuthenticatedEvent());
      } else {
        add(UnAuthenticatedEvent());
      }
    });
    on<AuthenticatedEvent>((event, emit) => emit(AuthenticatedState()));
    on<UnAuthenticatedEvent>((event, emit) => emit(UnAuthenticatedState()));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
