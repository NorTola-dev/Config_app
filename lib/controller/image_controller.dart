import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  ImagePicker picker = ImagePicker();

  File? image;
  File? video;

  void getImageGallery() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = File(file.path);
      video = null;
      print(file.path);
    }
    notifyListeners();
  }

  void getImageCamera() async {
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      image = File(file.path);
      video = null;

      Gal.putImage(file.path);

      print(file.path);
    }
    notifyListeners();
  }

  void openGalary() async {
    await Gal.open();
  }

  void getVideo() async {
    XFile? file = await picker.pickVideo(source: ImageSource.camera);

    if (file != null) {
      Gal.putVideo(file.path);
      video = File(file.path);
      image = null;
    }
  }

  Future<void> getVideoGalary() async {
    XFile? file = await picker.pickVideo(source: ImageSource.gallery);

    if (file != null) {
      video = File(file.path);
      image = null;
      notifyListeners();
    }
  }
}
