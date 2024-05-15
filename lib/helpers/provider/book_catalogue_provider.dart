// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class BookCatalogueProvider extends ChangeNotifier {
  // Initialize  values
  List<Map<String, dynamic>> _reviewsList = [];

  // Getter method to access the values (read-only)
  List<Map<String, dynamic>> get reviewsList => _reviewsList;

  // Methods to add new value to the values

  Future setReviewsList(Map<String, dynamic> newReview) async {
    _reviewsList.add(newReview);
    notifyListeners();
  }

  // Future updateReviewsList()
}
