import 'package:flutter/material.dart';
import 'package:praktikum_flutter/detail_profile.dart';

class ListProfile extends StatelessWidget {
  const ListProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Profile')),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile1.jpg'),
            ),
            title: Text('John Doe'),
            subtitle: Text('Software Engineer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailProfile()),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile2.jpg'),
            ),
            title: Text('Jane Smith'),
            subtitle: Text('Product Manager'),
          ),
        ],
      ),
    );
  }
}
