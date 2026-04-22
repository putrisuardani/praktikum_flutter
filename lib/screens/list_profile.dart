import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:praktikum_flutter/models/profile.dart';
import 'package:praktikum_flutter/screens/detail_profile.dart';
import 'package:provider/provider.dart';
import 'package:praktikum_flutter/provider/profile_provider.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  List<Profile> profiles = [];
  int counter = 0;

  void addItem() {
    counter = counter + 1;
    int rand = counter % 2 + 1;
    final newProfile = Profile(
      id: counter,
      name: "Putri $counter",
      bio: "Flutter Developer",
      coverPhoto: "assets/images/background$rand.jpg",
      profilePhoto: "https://picsum.photos/200/300?random=$counter",
    );
    context.read<ProfileProvider>().addProfile(newProfile);
  }

  void deleteitem(int id) {
    context.read<ProfileProvider>().deleteProfile(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Profile')),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profiles = profileProvider.profiles;
          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return Dismissible(
                key: Key(profile.id.toString()),
                onDismissed: (direction) {
                  deleteitem(profile.id);
                  Fluttertoast.showToast(
                    msg: "Profile ${profile.name} dihapus",
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profile.profilePhoto),
                  ),
                  title: Text(profile.name),
                  subtitle: Text(profile.bio),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailProfile(profileId: profile.id),
                    ),
                  ),
                ),
              );
            },
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
