import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/components/add_review_dialog.dart';
import 'package:giventake/screens/profile/blocs/get_reviews/get_reviews_bloc.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddReviewDialog();
                },
              );
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // children: [
                        //   Text('User: ${review['username']}'),
                        //   const SizedBox(
                        //       height: 8), // Espaçamento entre as linhas
                        //   Text('${review['review']}'),
                        // ],
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
