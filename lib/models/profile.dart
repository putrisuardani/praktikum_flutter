class Profile {
  int? id;
  String name;
  String bio;
  String coverPhoto;
  String profilePhoto;

  Profile({
    required this.id,
    required this.name,
    required this.bio,
    required this.coverPhoto,
    required this.profilePhoto,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      coverPhoto: json['cover_photo'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'cover_photo': coverPhoto,
      'profile_photo': profilePhoto,
    };
  }
}
