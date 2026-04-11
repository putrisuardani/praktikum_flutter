import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  List<Profile> _profiles = [];
  List<Profile> get profiles => _profiles;

  Future<void> fetchProfiles() async {
    final snapshot = await _firestore.collection('profiles').get();
    _profiles = snapshot.docs.map((doc) {
      final data = doc.data();
      return Profile(id: doc.id, name: data['name'], bio: data['bio']);
    }).toList();
    notifyListeners();
  }

  Future<void> addProfile(Profile profile) async {
    final docRef = await _firestore.collection('profiles').add(profile.toMap());
    _profiles.add(Profile(id: docRef.id, name: profile.name, bio: profile.bio));
    notifyListeners();
  }

  Future<void> updateProfile(String id, Profile profile) async {
    await _firestore.collection('profiles').doc(id).update(profile.toMap());

    final index = _profiles.indexWhere((p) => p.id == id);
    if (index != -1) {
      _profiles[index] = profile;
      notifyListeners();
    }
  }

  Future<void> deleteProfile(String id) async {
    await _firestore.collection('profiles').doc(id).delete();
    _profiles.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
