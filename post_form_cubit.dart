import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_form_state.dart';

class PostFormCubit extends Cubit<PostFormState> {
  PostFormCubit() : super(PostFormState.initial());

  void titleChanged(String title) {
    if (title.isNotEmpty) {
      emit(state.copyWith(isValidTitle: true));
    }
  }

  void categoryChanged(String category) {
    if (category.isNotEmpty) {
      emit(state.copyWith(isValidCategory: true));
    }
  }

  void descriptionChanged(String description) {
    if (description.isNotEmpty) {
      emit(state.copyWith(isValidDescription: true));
    }
  }
}
