import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/myhomecpntroller.dart';
import 'package:machine_test/details_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyHomeController controller = Get.put(MyHomeController());
  int initiallyDisplayedImages = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getUserDetailApi(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),

                  // Set itemCount to initiallyDisplayedImages initially
                  itemCount: initiallyDisplayedImages,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              imageUrl: controller.images[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            controller.images[index].xtImage.toString(),
                            fit: BoxFit.fill,
                            // height: 300,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (controller.images.length > initiallyDisplayedImages)
                initiallyDisplayedImages == 10
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              initiallyDisplayedImages += 2;
                            });
                          },
                          child: Text('Load More'),
                        ),
                      ),
            ],
          );
        },
      ),
    );
  }
}
