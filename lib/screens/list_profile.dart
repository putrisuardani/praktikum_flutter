import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:praktikum_flutter/models/profile.dart';
import 'package:praktikum_flutter/provider/profile_provider.dart';
import 'package:praktikum_flutter/screens/detail_profile.dart';
import 'package:provider/provider.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  List<Profile> profiles = [];

  void addItem() {
    final provider = context.read<ProfileProvider>();

    int lastIndex = provider.profiles.length;

    final newProfile = Profile(
      id: lastIndex + 1,
      name: "Putri ${lastIndex + 1}",
      bio: "Flutter Developer",
    );
    provider.addProfile(newProfile);
  }

  void deleteitem(int index) {
    context.read<ProfileProvider>().deleteProfile(index);
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
                key: Key(index.toString()),
                onDismissed: (direction) {
                  final deletedItem = profiles[index];
                  deleteitem(index);
                  Fluttertoast.showToast(
                    msg: "Profile ${deletedItem.name} dihapus",
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=10',
                    ),
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
