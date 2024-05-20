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

final class GetReviewsCountInitial extends GetReviewsState {}

final class GetReviewsCountFailure extends GetReviewsState {}

final class GetReviewsCountProcess extends GetReviewsState {}

final class GetReviewsCountSuccess extends GetReviewsState {
  final int reviews;

  const GetReviewsCountSuccess(this.reviews);

  @override
  List<Object> get props => [reviews];
}