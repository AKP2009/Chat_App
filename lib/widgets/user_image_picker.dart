import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key,required this.OnPickImage});
  final void Function(File pickedImage) OnPickImage;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async{
    final pickedImage=await ImagePicker().pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
      maxWidth: 150,
      imageQuality: 50
    );
    if(pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile=File( pickedImage .path);
    });
    widget.OnPickImage(_pickedImageFile! );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
