class Profile {
  int? id;
  String name;
  String bio;

  Profile({required this.id, required this.name, required this.bio});

  Profile copyWith({int? id, String? name, String? bio}) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
    );
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(id: map['id'], name: map['name'], bio: map['bio']);
  }

  Map<String, dynamic> toMap() {
    final map = {'id': id, 'name': name, 'bio': bio};

    return map;
  }
}
