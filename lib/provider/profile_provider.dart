import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final List<Profile> _profiles = [];

  List<Profile> get profiles => List.unmodifiable(_profiles);

  void addProfile(Profile profile) {
    _profiles.add(profile);
    notifyListeners();
  }

  void updateProfile(Profile updatedProfile) {
    final index = _profiles.indexWhere((p) => p.id == updatedProfile.id);

    if (index != -1) {
      _profiles[index] = updatedProfile;
      notifyListeners();
    }
  }

  void deleteProfile(int id) {
    final index = _profiles.indexWhere((p) => p.id == id);
    if (index != -1) {
      _profiles.removeAt(index);
      notifyListeners();
    }
  }

  Profile? getById(int id) {
    return _profiles.where((p) => p.id == id).isNotEmpty
        ? _profiles.firstWhere((p) => p.id == id)
        : null;
  }
}
