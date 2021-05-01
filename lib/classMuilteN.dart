import 'package:flutter/material.dart';

class MultipleNotifier extends ChangeNotifier {
  List<String> _selectedItems;
  List<String> _selectedItemsAr;
  List<String> _selectedItemsEn;
  MultipleNotifier(this._selectedItems,this._selectedItemsAr,this._selectedItemsEn);
  List<String> get selectedItems => _selectedItems;
  List<String> get selectedItemsAr => _selectedItemsAr;
  List<String> get selectedItemsEn => _selectedItemsEn;
  bool isHaveItem(String value) => _selectedItems.contains(value);
  bool isHaveItemAr(String value) => _selectedItemsAr.contains(value);
  bool isHaveItemEn(String value) => _selectedItemsEn.contains(value);
  addItem(String value) {
    if (!isHaveItem(value)) {
      _selectedItems.add(value);

      notifyListeners();
    }
  }
  removeItem(String value) {
    if (isHaveItem(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }
  addItemAr(String value) {
    if (!isHaveItemAr(value)) {
      _selectedItemsAr.add(value);

      notifyListeners();
    }
  }
  removeItemAr(String value) {
    if (isHaveItemAr(value)) {
      _selectedItemsAr.remove(value);
      notifyListeners();
    }
  }
  addItemEn(String value) {
    if (!isHaveItemEn(value)) {
      _selectedItemsEn.add(value);

      notifyListeners();
    }
  }
  removeItemEn(String value) {
    if (isHaveItemEn(value)) {
      _selectedItemsEn.remove(value);
      notifyListeners();
    }
  }
}