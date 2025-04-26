import 'package:collection/collection.dart';

class RatingCalculator {
  static num calculateRating(List<num> rating) {
    return rating.map((e) => e).average;
  }
}