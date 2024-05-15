import 'dart:developer';

import 'package:book_catalogue_app/components/buttons.dart';
import 'package:book_catalogue_app/helpers/constant/book_genre.dart';
import 'package:book_catalogue_app/helpers/constant/colors.dart';
import 'package:book_catalogue_app/helpers/constant/sizer.dart';
import 'package:book_catalogue_app/helpers/models/add_book_model.dart';
import 'package:book_catalogue_app/helpers/routes/route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  Stream<List<AddBookModel>> readBookCataloue() => FirebaseFirestore.instance
      .collection('Book-catalogue')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AddBookModel.fromJson(doc.data()))
          .toList());

  // To delete a book from firestore database

  Future<void> deleteBook(String bookId) async {
    try {
      FirebaseFirestore.instance
          .collection('Book-catalogue')
          .doc(bookId)
          .delete()
          .whenComplete(() {
        const snackBar = SnackBar(content: Text('delete successfully!!! ✅'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } catch (e) {
      const snackBar =
          SnackBar(content: Text('delete unsuccesful 🤦‍♂️, re-try'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    log("==> init state: $readBookCataloue()");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizer(true, 6, context)),
          child: Text(
            'All BOOK',
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
      body: StreamBuilder(
          stream: readBookCataloue(),
          builder: (context, snapShot) {
            log("==> snapShot: ${snapShot.hasData}");
            if (snapShot.hasData) {
              final books = snapShot.data!;

              return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteHelper.addBookRoute,
                              arguments: {
                                "isEdited": true,
                                "id": books[index].id,
                                "bookName": books[index].bookName,
                                "author": books[index].author,
                                "genre": books[index].genre,
                                "publishedDate": books[index].publishedDate,
                                "available": books[index].available,
                                "reviews": books[index].reviews,
                              });
                        },
                        child: Card(
                          color: AppColors.cardBgColor,
                          child: ListTile(
                            title: Text(
                              books[index].bookName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                color: AppColors.textgrey,
                              ),
                            ),
                            subtitle: Text(
                              books[index].author,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                color: AppColors.textgrey,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  await deleteBook(books[index].id);
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: sizer(false, 20, context),
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                  itemCount: books.length);
            } else {
              return Center(
                child: Text(
                  "No Book, add one!!",
                  style: TextStyle(
                    fontSize: sizer(false, 18, context),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Abel',
                    height: 1.3,
                    color: AppColors.textColor,
                  ),
                ),
              );
            }
          }),
      floatingActionButton: Button(
        buttonText: 'Add Book',
        isColored: true,
        isEdited: false,
        buttonFuntions: () async {
          Navigator.pushReplacementNamed(context, RouteHelper.addBookRoute,
              arguments: {
                'isEdited': false,
              });
        },
      ),
    );
  }
}
