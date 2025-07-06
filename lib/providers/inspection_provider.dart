import 'package:flutter/material.dart';
import '../structure/inspection_item.dart';

//Here i implemented the the remarks and score from inspection_item.dart
class InspectionProvider extends ChangeNotifier {
  final Map<String, InspectionItem> _items = {};

  Map<String, InspectionItem> get items => _items;

  void setScore(String id, int score) {
    _items[id] = _items[id] ?? InspectionItem(id: id);
    _items[id]!.score = score;
    notifyListeners();
  }

  void setRemarks(String id, String remarks) {
    _items[id] = _items[id] ?? InspectionItem(id: id);
    _items[id]!.remarks = remarks;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return _items.map((key, value) => MapEntry(key, value.toJson()));
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}
