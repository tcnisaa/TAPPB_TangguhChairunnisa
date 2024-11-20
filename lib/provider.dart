import 'package:flutter/foundation.dart';

class ReviewProvider with ChangeNotifier {
  List<String> reviews = [];

  void addReview(String review) {
    reviews.add(review);
    notifyListeners();
  }
}
