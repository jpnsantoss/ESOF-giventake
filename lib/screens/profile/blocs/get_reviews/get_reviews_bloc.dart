import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:review_repository/review_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'get_reviews_event.dart';
part 'get_reviews_state.dart';

class GetReviewsBloc extends Bloc<GetReviewsEvent, GetReviewsState> {
  final ReviewRepo _reviewRepo;
  final UserRepository _userRepository;
  GetReviewsBloc(
    this._reviewRepo,
    this._userRepository,
  ) : super(GetReviewsInitial()) {
    on<GetReviews>(getReviews);
  }

  Future<void> getReviews(
      GetReviews event, Emitter<GetReviewsState> emit) async {
    emit(GetReviewsProcess());
    try {
      final reviews = await _reviewRepo.getReviews(event.userId);
      for (Review review in reviews) {
        review.fetchUser(_userRepository);
      }
      emit(GetReviewsSuccess(reviews));
    } catch (e) {
      emit(GetReviewsFailure());
    }
  }
}
