import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewDialog extends StatefulWidget {
  const AddReviewDialog({super.key});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  String reviewText = '';
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  reviewText = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a review';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                this.rating = rating;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              // Save the review and rating...
              Navigator.of(context)
                  .pop({'review': reviewText, 'rating': rating});
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
