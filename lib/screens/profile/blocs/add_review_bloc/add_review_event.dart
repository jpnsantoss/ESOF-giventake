part of 'add_review_bloc.dart';

abstract class AddReviewEvent extends Equatable {
  const AddReviewEvent();

  @override
  List<Object> get props => [];
}

class AddReviewRequested extends AddReviewEvent {
  final String review;
  final double rating;
  final String fromUserId;
  final String toUserId;

  const AddReviewRequested({
    required this.review,
    required this.rating,
    required this.fromUserId,
    required this.toUserId,
  });

  @override
  List<Object> get props => [review, rating, fromUserId, toUserId];
}
