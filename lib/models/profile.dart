class Profile {
  final String? id;
  String name;
  String bio;

  Profile({this.id, required this.name, required this.bio});

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(id: map['id'], name: map['name'], bio: map['bio'] ?? '');
  }

  Map<String, dynamic> toMap() {
    final map = {'id': id, 'name': name, 'bio': bio};

    return map;
  }
}
