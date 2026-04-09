class Profile {
  int? id;
  String name;
  String bio;

  Profile({required this.id, required this.name, required this.bio});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(id: json['id'], name: json['name'], bio: json['bio']);
  }

  Map<String, dynamic> toJson() {
    final json = {'name': name, 'bio': bio};

    return json;
  }
}
