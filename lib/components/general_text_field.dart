// ignore_for_file: prefer_const_constructors

import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final double? fontSize;
  final FocusNode? focusNode;
  final TextEditingController? textController;
  final bool multiline;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validator;
  final Widget? prefixIcon, suffixIcon;
  final StrutStyle? strutStyle;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const GeneralTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
    this.textController,
    this.textCapitalization,
    this.onSaved,
    this.fontSize,
    this.validator,
    this.textAlignVertical,
    this.strutStyle,
    this.autoValidateMode,
    this.multiline = false,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return TextFormField(
      focusNode: focusNode,
      maxLength: maxLength,
      autofocus: true,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      controller: textController ?? controller,
      onSaved: onSaved,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.center, // textAlignVertical,
      autovalidateMode: autoValidateMode,
      maxLines: multiline ? 5 : 1,
      minLines: multiline ? 5 : 1,
      cursorHeight: sizer(true, 20.0, context),
      keyboardType: keyboardType ?? TextInputType.text,
      style: TextStyle(
          height: sizer(true, 1.4, context),
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: fontSize ?? sizer(true, 13, context)),
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0.5,
            color: AppColors.secondaryRedColor,
          ),
        ),
        counter: const Offstage(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0.5,
            color: AppColors.secondaryRedColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical:
                multiline ? sizer(false, 5, context) : sizer(false, 5, context),
            horizontal: sizer(true, 20, context)),
        fillColor: AppColors.textFieldBackgroundColor,
        hintText: hintText ?? '',
        hintStyle: TextStyle(
            height: sizer(true, 1.4, context),
            color: AppColors.lightGrey,
            fontSize: fontSize ?? sizer(true, 13, context)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.buttonColor,
          width: 1.0,
        )),
        errorStyle: TextStyle(
            height: sizer(true, 1.4, context),
            fontSize: sizer(true, 12, context)),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(sizer(true, 12, context)),
        //   borderSide: const BorderSide(
        //     width: 0.5, color: AppColors.lightGrey,
        //     //  style: BorderStyle.none,
        //   ),
        // ),
        filled: true,
      ),

      //autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ??
          (val) {
            if ((val?.length ?? 0) == 0) {
              return "";
            } else {
              return null;
            }
          },
    );
  }
}
