import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/profile.dart';

class ProfileProvider with ChangeNotifier {
  final String baseUrl = 'http://172.20.10.3:8000/api/profiles';

  List<Profile> _profiles = [];
  List<Profile> get profiles => _profiles;

  Future<void> fetchProfiles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        List<dynamic> data;

        if (decoded is List) {
          data = decoded;
        } else if (decoded is Map && decoded['data'] != null) {
          data = decoded['data'];
        } else {
          data = [];
        }

        _profiles = data.map((json) => Profile.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching profiles: $e');
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profile.toJson()),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        await fetchProfiles();
      }
    } catch (e) {
      print('Error adding profile: $e');
    }
  }

  Future<void> updateProfile(int id, Profile updatedProfile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedProfile.toJson()),
    );

    if (response.statusCode == 200) {
      await fetchProfiles(); // refresh data dari server
      notifyListeners();
    } else {
      throw Exception('Gagal update profil');
    }
  }

  Future<void> deleteProfile(int id) async {
    try {
      final url = '$baseUrl/$id';
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        _profiles.removeWhere((p) => p.id == id);
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }
}
