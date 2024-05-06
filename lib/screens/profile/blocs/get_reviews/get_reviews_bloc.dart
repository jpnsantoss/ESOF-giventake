import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:review_repository/request_repository.dart';

part 'get_reviews_event.dart';
part 'get_reviews_state.dart';

class GetReviewsBloc extends Bloc<GetReviewsEvent, GetReviewsState> {
  final ReviewRepo _reviewRepo;
  GetReviewsBloc(this._reviewRepo) : super(GetReviewsInitial()) {
    on<GetReviews>(getReviews);
  }

  Future<void> getReviews(
      GetReviews event, Emitter<GetReviewsState> emit) async {
    emit(GetReviewsProcess());
    try {
      final reviews = await _reviewRepo.getReviews(event.userId);
      emit(GetReviewsSuccess(reviews));
    } catch (e) {
      emit(GetReviewsFailure());
    }
  }
}
