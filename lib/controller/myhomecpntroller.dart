import 'dart:convert';

import 'package:get/get.dart';
import 'package:machine_test/image_model.dart';
import 'package:http/http.dart' as http;

class MyHomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  List<ImageData> images = [];

  Future<List<ImageData>> getUserDetailApi() async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://dev3.xicom.us/xttest/getdata.php'));
      request.fields['user_id'] = "108";
      request.fields['offset'] = '0';
      request.fields['type'] = 'popular';
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(response.body);
        if (data['status'] == "success") {
          List<dynamic> imageList = data['images'];
          images = imageList.map((json) => ImageData.fromJson(json)).toList();
        } else {
          throw Exception('API returned error: ${data['message']}');
        }
      } else {
        throw Exception('Failed to fetch images. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching images: $error');
      throw error;
    }

    return images;
  }
}
