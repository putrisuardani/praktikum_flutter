import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:praktikum_flutter/provider/profile_provider.dart';
import 'package:image_picker/image_picker.dart';

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
  late TextEditingController _coverPhotoController;
  late TextEditingController _profilePhotoController;

  @override
  void initState() {
    super.initState();

    final provider = context.read<ProfileProvider>();
    final profile = provider.getById(widget.id);

    _nameController = TextEditingController(text: profile?.name ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
    _coverPhotoController = TextEditingController(
      text: profile?.coverPhoto ?? '',
    );
    _profilePhotoController = TextEditingController(
      text: profile?.profilePhoto ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _coverPhotoController.dispose();
    _profilePhotoController.dispose();
    super.dispose();
  }

  Future<void> pickCoverPhoto(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _coverPhotoController.text = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                controller: _coverPhotoController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Cover Photo'),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => pickCoverPhoto(ImageSource.camera),
                      child: Text('Kamera'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => pickCoverPhoto(ImageSource.gallery),
                      child: Text('Galeri'),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _profilePhotoController,
                decoration: InputDecoration(labelText: 'Profile Photo (url)'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final provider = context.read<ProfileProvider>();

                    provider.updateProfile(
                      widget.id,
                      _nameController.text,
                      _bioController.text,
                      _coverPhotoController.text,
                      _profilePhotoController.text,
                    );

                    if (mounted) {
                      Navigator.pop(context, true);
                    }
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
