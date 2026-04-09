import 'package:flutter/material.dart';
import 'package:praktikum_flutter/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.id});

  final int id;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final profile = provider.getById(widget.id);

    _nameController = TextEditingController(text: profile?.name ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.updateProfile(
                      widget.id,
                      _nameController.text,
                      _bioController.text,
                    );

                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
