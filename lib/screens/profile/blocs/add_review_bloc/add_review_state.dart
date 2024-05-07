part of 'add_review_bloc.dart';

sealed class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

final class AddReviewInitial extends AddReviewState {}

final class AddReviewFailure extends AddReviewState {}

final class AddReviewProcess extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {}
