part of 'get_reviews_bloc.dart';

sealed class GetReviewsState extends Equatable {
  const GetReviewsState();

  @override
  List<Object> get props => [];
}

final class GetReviewsInitial extends GetReviewsState {}

final class GetReviewsFailure extends GetReviewsState {}

final class GetReviewsProcess extends GetReviewsState {}

final class GetReviewsSuccess extends GetReviewsState {
  final List<Review> reviews;

  const GetReviewsSuccess(this.reviews);

  @override
  List<Object> get props => [reviews];
}
