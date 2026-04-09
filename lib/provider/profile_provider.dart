import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final List<Profile> _profiles = [];

  List<Profile> get profiles => List.unmodifiable(_profiles);

  void addProfile(Profile profile) {
    _profiles.add(profile);
    notifyListeners();
  }

  void updateProfile(int id, String name, String bio) {
    final index = _profiles.indexWhere((p) => p.id == id);
    if (index != -1) {
      _profiles[index] = Profile(id: id, name: name, bio: bio);
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
