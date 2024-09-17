import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String _phoneNumber = "";
  String _firstName = "";
  String _lastName = "";
  bool _isLogged = false;

  String get phoneNumber => _phoneNumber;

  String get fullName => "$_firstName $_lastName";

  bool get isLogged => _isLogged;

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setFullName([String firstName = "", String lastName = ""]) {
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }

  void setIsLogged(bool isLogged) {
    _isLogged = isLogged;
    notifyListeners();
  }
}
