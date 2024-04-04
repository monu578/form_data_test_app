import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:email_validator/email_validator.dart';

class DetailController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    firstNameController.text = "";
    lastNameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    super.onInit();
  }

  void submitForm(String imageUrl) async {
    if (_validateForm()) {
      File? file;
      file = await imageFromUrlToFile(imageUrl);
      try {
        var request = http.MultipartRequest('POST', Uri.parse('http://dev3.xicom.us/xttest/savedata.php'));
        request.fields['first_name'] = firstNameController.text.trim();
        request.fields['last_name'] = lastNameController.text.trim();
        request.fields['email'] = emailController.text.trim();
        request.fields['phone'] = phoneController.text.trim();
        // request.fields['user_image'] = file!.path.toString();
        if (file != null) {
          request.files.add(await http.MultipartFile.fromPath('user_image', file.path.split('/').last));
          print(file.path);
        }
        final response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          Get.snackbar('Success', 'User details saved successfully.', snackPosition: SnackPosition.BOTTOM);
          print('User details saved successfully.');
        } else {
          print('Failed to save user details. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred while saving user details: $error');
      }
    }
  }

  bool _validateForm() {
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter first name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (lastNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter last name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (!isValidEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } else if (phoneController.text.trim().isNotEmpty && lastNameController.text.trim().isNotEmpty && firstNameController.text.trim().isNotEmpty && isValidEmail(emailController.text)) {
      Get.snackbar(
        'Success',
        'User details saved successfully.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Future<File?> imageFromUrlToFile(String imageUrl) async {
    File? file;
    print("${imageUrl}");
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      if (Platform.isAndroid) {
        const downloadsFolderPath = "/storage/emulated/0/Download/";
        Directory dir = Directory(downloadsFolderPath);
        file = File('${dir.path}/image.png');
      } else if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        file = File('${dir.path}/image.png');
      }
      await file?.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to load image from $imageUrl');
    }
  }

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }
}
