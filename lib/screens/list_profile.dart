import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:praktikum_flutter/models/profile.dart';
import 'package:praktikum_flutter/screens/detail_profile.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  List<Profile> profiles = [];
  int counter = 0;

  void addItem() {
    setState(() {
      counter = counter + 1;
      int rand = counter % 2 + 1;
      profiles.add(
        Profile(
          id: counter,
          name: "Putri $counter",
          bio: "Flutter Developer",
          coverPhoto: "assets/images/background$rand.jpg",
          profilePhoto: "https://picsum.photos/200/300?random=$counter",
        ),
      );
    });
  }

  void deleteitem(int id) {
    setState(() {
      profiles.removeWhere((profile) => profile.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Profile')),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          print("index: $index");
          print("ID: ${profile.id}");
          return Dismissible(
            key: Key(profile.id.toString()),
            onDismissed: (direction) {
              final deletedItem = profile.id;
              deleteitem(deletedItem);
              Fluttertoast.showToast(msg: "Profile ${profile.name} dihapus");
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profile.profilePhoto),
              ),
              title: Text(profile.name),
              subtitle: Text(profile.bio),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProfile(profile: profile),
                  ),
                );
                setState(() {});
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
