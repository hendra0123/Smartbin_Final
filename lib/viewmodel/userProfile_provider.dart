import 'dart:io';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  String _fullName = "Hendra";
  File? _profileImage;
  String? _username;
  String? _email;
  String? _phoneNumber;

  String get fullName => _fullName;
  File? get profileImage => _profileImage;
  String? get username => _username;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  void updateName(String name) {
    _fullName = name;
    notifyListeners();
  }

  void updateProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updatePhoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
    notifyListeners();
  }
}
