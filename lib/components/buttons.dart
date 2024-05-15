// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String? buttonText;
  final String? editedButtonText;
  final bool isColored;
  final bool isEdited;
  final Function buttonFuntions;
  const Button({
    super.key,
    this.buttonText,
    this.isColored = true,
    required this.buttonFuntions,
    this.editedButtonText,
    required this.isEdited,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.buttonFuntions.call();
      },
      child: Container(
        height: sizer(false, 32, context),
        decoration: BoxDecoration(
          color: widget.isColored
              ? AppColors.buttonColor
              : AppColors.secondButtonColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            widget.isEdited ? widget.editedButtonText! : widget.buttonText!,
            style: TextStyle(
              fontSize: sizer(true, 14, context),
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: AppColors.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
