import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final List<Profile> _profiles = [];

  List<Profile> get profiles => _profiles;

  void addProfile(Profile profile) {
    _profiles.add(profile);
    notifyListeners();
  }

  void updateProfile(int index, Profile profile) {
    _profiles[index] = profile;
    notifyListeners();
  }

  void deleteProfile(int index) {
    _profiles.removeAt(index);
    notifyListeners();
  }
}
