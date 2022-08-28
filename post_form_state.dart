part of 'post_form_cubit.dart';

class PostFormState extends Equatable {
  final bool isValidTitle;
  final bool isValidDescription;
  final bool isValidCategory;

  const PostFormState._({
    required this.isValidTitle,
    required this.isValidDescription,
    required this.isValidCategory,
  });

  factory PostFormState.initial() {
    return const PostFormState._(
      isValidTitle: false,
      isValidDescription: false,
      isValidCategory: false,
    );
  }

  PostFormState copyWith({
    bool? isValidTitle,
    bool? isValidDescription,
    bool? isValidCategory,
  }) {
    return PostFormState._(
      isValidTitle: isValidTitle ?? this.isValidTitle,
      isValidDescription: isValidDescription ?? this.isValidDescription,
      isValidCategory: isValidCategory ?? this.isValidCategory,
    );
  }

  @override
  List<Object?> get props => [
        isValidTitle,
        isValidCategory,
        isValidDescription,
      ];
}
