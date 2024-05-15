// ignore_for_file: prefer_const_constructors

import 'package:book_catalogue_app/components/buttons.dart';
import 'package:book_catalogue_app/components/general_text_field.dart';
import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  final TextEditingController? reviewerController;
  final TextEditingController? ratingController;
  final TextEditingController? commentController;

  const Review({
    super.key,
    this.reviewerController,
    this.ratingController,
    this.commentController,
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralTextField(
            textController: widget.reviewerController ?? controller,
            hintText: 'Reviewer name',
            fontSize: sizer(true, 14, context),
          ),
          SizedBox(
            height: 10,
          ),
          GeneralTextField(
            textController: widget.ratingController ?? controller,
            hintText: 'Rating',
            fontSize: sizer(true, 14, context),
          ),
          SizedBox(
            height: 10,
          ),
          GeneralTextField(
            textController: widget.commentController ?? controller,
            hintText: 'Comment',
            fontSize: sizer(true, 14, context),
          ),
          SizedBox(
            height: 10,
          ),
          Button(
            buttonText: 'Remove',
            isEdited: false,
            buttonFuntions: () {
              widget.reviewerController?.clear();
              widget.ratingController?.clear();
              widget.commentController?.clear();
            },
          )
        ],
      ),
    );
  }
}
