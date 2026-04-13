import 'package:flutter/material.dart';
import 'package:praktikum_flutter/models/profile.dart';
import 'package:praktikum_flutter/screens/detail_profile.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  int counter = 0;

  List<Profile> profiles = [];

  void addItem() {
    setState(() {
      counter++;
      profiles.add(
        Profile(
          id: counter,
          nama: "Putri Tes From List Profile $counter",
          bio: "Flutter Developer $counter",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Profile"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Dismissible(
            key: Key(profile.id.toString()),
            onDismissed: (direction) => setState(
              () => profiles.removeWhere((item) => item.id == profile.id),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: Image.network(
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
                ).image,
              ),
              title: Text(profile.nama),
              subtitle: Text(profile.bio),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProfile(profile: profile),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
