// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookModel {
  final String id;
  final String bookName;
  final String author;
  final String genre;
  final String publishedDate;
  final bool available;
  final Map<String, dynamic> reviews;
  final Timestamp createdAt;
  AddBookModel(
      {required this.id,
      required this.bookName,
      required this.author,
      required this.genre,
      required this.publishedDate,
      required this.available,
      required this.reviews,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'bookName': bookName,
        'author': author,
        'genre': genre,
        'publishedDate': publishedDate,
        'available': available,
        'reviews': reviews,
      };

  static AddBookModel fromJson(Map<String, dynamic> json) => AddBookModel(
        id: json['id'],
        createdAt: json['createdAt'],
        bookName: json['bookName'],
        author: json['author'],
        genre: json['genre'],
        publishedDate: json['publishedDate'],
        available: json['available'],
        reviews: json['reviews'],
      );
}
