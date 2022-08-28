part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AuthenticatedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class UnAuthenticatedEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}
