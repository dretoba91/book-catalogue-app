import 'package:book_catalogue_app/screens/add_books.dart';
import 'package:book_catalogue_app/screens/all_books.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static const String addBookRoute = 'AddBook';
  static const String allBookRoute = 'AllBook';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case addBookRoute:
        final addBooks = settings.arguments as Map<String, dynamic>;
        return _getPageRoute(
            routeName: settings.name!,
            screen: AddBook(
              isEdited: addBooks['isEdited'],
              id: addBooks['id'],
              bookName: addBooks['bookName'],
              author: addBooks['author'],
              genre: addBooks['genre'],
              publishedDate: addBooks['publishedDate'],
              available: addBooks['available'],
              reviews: addBooks['reviews'],
            ));

      case allBookRoute:
        return _getPageRoute(
            routeName: settings.name!, screen: const AllBooks());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  PageRoute _getPageRoute({required String routeName, required Widget screen}) {
    return MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
        ),
        builder: (_) => screen);
  }
}
