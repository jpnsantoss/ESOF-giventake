import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:giventake/components/add_review_dialog.dart';
import 'package:giventake/screens/profile/blocs/add_review_bloc/add_review_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_reviews/get_reviews_bloc.dart';

class ReviewsScreen extends StatefulWidget {
  final String toUserId;

  const ReviewsScreen({
    super.key,
    required this.toUserId,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final addReviewBloc = BlocProvider.of<AddReviewBloc>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              final result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (context) {
                  return const AddReviewDialog();
                },
              );

              if (result != null && authBloc.state.user != null) {
                final review = result['review'] as String;
                final rating = result['rating'] as double;
                final fromUserId = authBloc.state.user!.uid;

                addReviewBloc.add(
                  AddReviewRequested(
                    review: review,
                    rating: rating,
                    fromUserId: fromUserId,
                    toUserId: widget.toUserId,
                  ),
                );
              }
            },
            child: const Text('Add new review'),
          ),
        ),
        Center(
          child: BlocBuilder<GetReviewsBloc, GetReviewsState>(
            builder: (context, state) {
              if (state is GetReviewsSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.reviews.map((review) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(20.0),
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), // Cor da sombra
                            spreadRadius: 3, // Raio de propagação da sombra
                            blurRadius: 7, // Raio de desfoque da sombra
                            offset:
                                const Offset(0, 3), // Deslocamento da sombra
                          ),
                        ],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundImage: NetworkImage(), // assuming 'avatarUrl' is the field for the user's avatar URL
                              //   radius: 20.0,
                              // ),
                              const SizedBox(width: 8.0),
                              Text(
                                review.fromUser!
                                    .name, // assuming 'name' is the field for the user's name
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            review
                                .comment, // assuming 'description' is the field for the review text
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star, // star icon
                                color:
                                    Colors.yellow, // yellow color for the star
                              ),
                              const SizedBox(
                                  width:
                                      4.0), // space between the star icon and the rating
                              Text(
                                '${review.rating}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else if (state is GetReviewsFailure) {
                return const Text('Failed to load reviews');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
