import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/detailscontroller.dart';
import 'package:machine_test/image_model.dart';

class DetailScreen extends StatelessWidget {
  final ImageData? imageUrl;
  final DetailController controller = Get.put(DetailController());

  DetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl!.xtImage.toString(),
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('First Name:')),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    controller: controller.firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text("Last Name:")),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: controller.lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text("Email:")),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text("Phone Number:")),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: controller.phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: Get.height / 5,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.submitForm(imageUrl!.xtImage.toString());
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
