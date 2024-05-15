// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:book_catalogue_app/components/buttons.dart';
import 'package:book_catalogue_app/components/general_text_field.dart';
import 'package:book_catalogue_app/components/review.dart';
import 'package:book_catalogue_app/helpers/constant/book_genre.dart';
import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:book_catalogue_app/helpers/models/add_book_model.dart';
import 'package:book_catalogue_app/helpers/provider/book_catalogue_provider.dart';
import 'package:book_catalogue_app/helpers/routes/route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/data.dart';

class AddBook extends StatefulWidget {
  final bool isEdited;
  final String? id;
  final String? bookName;
  final String? author;
  final String? genre;
  final String? publishedDate;
  final bool? available;
  final Map<String, dynamic>? reviews;
  const AddBook({
    super.key,
    required this.isEdited,
    this.id,
    this.bookName,
    this.author,
    this.genre,
    this.publishedDate,
    this.available,
    this.reviews,
  });

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  bool isChecked = false;
  bool isReviewMode = false;
  dynamic selectedValue;
  BookGenre? editedSelectedGenre;
  String genreValue = '';
  TextEditingController dateInput = TextEditingController();
  // reviews controller
  TextEditingController reviewerNameController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  // Input fields controller
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdited) {
      setState(() {
        editedSelectedGenre = widget.genre as BookGenre;
        bookNameController.text = widget.bookName!;
        authorNameController.text = widget.author!;
        // selectedValue = editedSelectedGenre;
        dateInput.text = widget.publishedDate!;
        isChecked = widget.available!;
        reviewerNameController.text = widget.reviews?['reviewrName'];
        ratingController.text = widget.reviews?['rating'];
        commentController.text = widget.reviews?['comment'];
      });
    }
    super.initState();
  }

  Future addBook() async {
    log("==> addbook function called : bookname: ${bookNameController.text} && author: ${authorNameController.text}");
    final bookId = widget.isEdited ? widget.id! : getId();
    final reviewsData =
        Provider.of<BookCatalogueProvider>(context, listen: false)
            .reviewsList
            .last;
    final postRef =
        FirebaseFirestore.instance.collection('Book-catalogue').doc(bookId);

    final postBook = AddBookModel(
      id: bookId,
      bookName: bookNameController.text,
      author: authorNameController.text,
      genre: genreValue,
      publishedDate: dateInput.text,
      available: isChecked,
      reviews: reviewsData,
      createdAt: Timestamp.now(),
    );

    final json = postBook.toJson();
    if (widget.isEdited) {
      postRef.update(json).whenComplete(() {
        const snackBar =
            SnackBar(content: Text('🎉🎈 updated successfully!!!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, RouteHelper.allBookRoute);
      });
    }
    postRef.set(json).whenComplete(() {
      const snackBar =
          SnackBar(content: Text('Book added successfully!!! 🎉🎈'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, RouteHelper.allBookRoute);
    });
  }

  String getId() {
    DateTime now = DateTime.now();
    String timestamp = DateFormat('yyyyMMddHHmmss').format(now);

    return timestamp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 6, context)),
          child: Text(
            'Add BOOK',
            style: TextStyle(
              fontSize: sizer(false, 18, context),
              fontWeight: FontWeight.w400,
              fontFamily: 'Abel',
              height: 1.3,
              color: AppColors.textColor,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.blackBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: sizer(true, 20, context),
            left: sizer(true, 20, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizer(false, 10, context),
              ),
              Text(
                'Book name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textgrey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GeneralTextField(
                textController: bookNameController,
                fontSize: sizer(false, 14, context),
              ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              Text(
                'Author name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textgrey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GeneralTextField(
                textController: authorNameController,
                fontSize: sizer(false, 14, context),
              ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              Text(
                'Genre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textgrey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButton<BookGenre>(
                  value: widget.isEdited ? editedSelectedGenre : selectedValue,
                  isExpanded: true,
                  hint: Text(
                    'select a genre',
                    style: TextStyle(
                      fontSize: sizer(true, 13, context),
                      fontWeight: FontWeight.w400,
                      height: sizer(true, 1.4, context),
                      color: AppColors.lightGrey,
                    ),
                  ),
                  dropdownColor: AppColors.blackBackground,
                  items: BookGenre.values.map((bookGenre) {
                    return DropdownMenuItem(
                      value: bookGenre,
                      child: Text(
                        bookGenre.name.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    log("==> ${value?.name.toString()}");
                    setState(() {
                      genreValue = value!.name.toString();
                      selectedValue = value;
                    });
                  }),
              // GeneralTextField(
              //   fontSize: sizer(false, 14, context),
              // ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              Text(
                'Publication Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textgrey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: dateInput,
                style: TextStyle(
                  height: sizer(true, 1.4, context),
                  decoration: TextDecoration.none,
                  color: AppColors.lightGrey,
                  fontSize: sizer(true, 13, context),
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  fillColor: AppColors.textFieldBackgroundColor,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: sizer(false, 5, context),
                    horizontal: sizer(true, 10, context),
                  ),
                  hintText: 'pick a date',
                  hintStyle: TextStyle(
                    height: sizer(true, 1.4, context),
                    color: AppColors.lightGrey,
                    fontSize: sizer(true, 13, context),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.buttonColor,
                    width: 1.0,
                  )),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    log("Date ==> $pickedDate");
                    String formatDate =
                        DateFormat('dd-MM-yyy').format(pickedDate);
                    log("format ==> $formatDate");
                    setState(() {
                      dateInput.text = formatDate;
                    });
                  }
                },
              ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: isChecked,
                      checkColor: AppColors.blackColor,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.buttonColor),
                      onChanged: (newBool) {
                        setState(() {
                          isChecked = newBool!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: sizer(true, 10, context),
                  ),
                  Text(
                    'Available',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: AppColors.textgrey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizer(false, 30, context),
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: AppColors.textgrey,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Review(
                reviewerController: reviewerNameController,
                ratingController: ratingController,
                commentController: commentController,
              ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              Button(
                buttonText: 'Add Reviews',
                isEdited: false,
                buttonFuntions: () {
                  // changeReviewMode();
                  Provider.of<BookCatalogueProvider>(context, listen: false)
                      .setReviewsList({
                    'reviewrName': reviewerNameController.text,
                    'rating': ratingController.text,
                    'comment': commentController.text
                  });
                },
              ),
              SizedBox(
                height: sizer(false, 15, context),
              ),
              widget.isEdited
                  ? Button(
                      buttonText: 'Edit Book',
                      isColored: false,
                      isEdited: false,
                      buttonFuntions: () async {
                        await addBook();
                      },
                    )
                  : Button(
                      buttonText: 'Add Book',
                      isColored: false,
                      isEdited: false,
                      buttonFuntions: () async {
                        await addBook();
                      },
                    ),
              SizedBox(
                height: sizer(false, 100, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
