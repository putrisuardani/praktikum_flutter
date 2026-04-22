import 'package:flutter/material.dart';
import 'package:praktikum_flutter/helpers/db_helper.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> _profiles = [];

  List<Profile> get profiles => _profiles;

  Future<void> fetchProfiles() async {
    try {
      _profiles = await DBHelper.getProfiles();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching profiles: $e');
    }
  }

  Future<void> addProfile(Profile newProfile) async {
    try {
      final int insertedId = await DBHelper.insertProfile(newProfile);
      final updatedProfile = newProfile.copyWith(id: insertedId);
      _profiles.add(updatedProfile);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding profile: $e');
    }
  }

  Future<void> updateProfile(int id, Profile profile) async {
    final db = await DBHelper.database;
    await db.update(
      'tb_profile',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchProfiles();
  }

  Future<void> deleteProfile(int id) async {
    final db = await DBHelper.database;
    await db.delete('tb_profile', where: 'id = ?', whereArgs: [id]);
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Profile? getById(int id) {
    return _profiles.where((p) => p.id == id).isNotEmpty
        ? _profiles.firstWhere((p) => p.id == id)
        : null;
  }
}
