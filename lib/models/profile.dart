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

  Profile copyWith({
    int? id,
    String? name,
    String? bio,
    String? coverPhoto,
    String? profilePhoto,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      bio: map['bio'],
      coverPhoto: map['coverPhoto'],
      profilePhoto: map['profilePhoto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'coverPhoto': coverPhoto,
      'profilePhoto': profilePhoto,
    };
  }
}
