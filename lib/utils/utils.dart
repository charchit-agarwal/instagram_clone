import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  } else {
    print('No image selected.');
  }
}

showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
