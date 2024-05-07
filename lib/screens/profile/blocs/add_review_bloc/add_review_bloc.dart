import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:review_repository/request_repository.dart';

part 'add_review_event.dart';
part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  final ReviewRepo reviewRepository;

  AddReviewBloc(this.reviewRepository) : super(AddReviewInitial()) {
    on<AddReviewRequested>((event, emit) async {
      emit(AddReviewProcess());
      try {
        await reviewRepository.addReview(
          event.fromUserId,
          event.toUserId,
          event.review,
          event.rating,
        );
        emit(AddReviewSuccess());
      } catch (_) {
        emit(AddReviewFailure());
      }
    });
  }
}
