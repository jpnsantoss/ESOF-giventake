part of 'get_reviews_bloc.dart';

sealed class GetReviewsEvent extends Equatable {
  const GetReviewsEvent();

  @override
  List<Object> get props => [];
}

class GetReviews extends GetReviewsEvent {
  final String userId;

  const GetReviews(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetReviewsCount extends GetReviewsEvent {
  final String userId;

  const GetReviewsCount(this.userId);

  @override
  List<Object> get props => [userId];
}
