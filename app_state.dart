part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}
class UnAuthenticatedState extends AppState {
  @override
  List<Object> get props => [];
}