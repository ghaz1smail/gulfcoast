import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:flutter/material.dart';
import 'package:gulfcoast/helper/get_initial.dart';
import 'package:gulfcoast/view/widgets/custom_button.dart';
import 'package:gulfcoast/view/widgets/custom_text_field.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController controller = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hint: 'VIN', controller: controller),
            CustomButton(
              title: 'search',
              loading: loading,
              function: () async {
                setState(() {
                  loading = true;
                });
                await getData(controller.text);
                setState(() {
                  loading = false;
                });
              },
              width: 100,
              color: appTheme.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

getData(vin) async {
  var headers = {
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*",
    'Accept': '*/*',
    'Cookie':
        'PHPSESSID=s47hhuls8icsq6aacgpelblvd4; currency=USD; default=eahcc6hsnckmkr99e77pdt5ps1; language=ru-ru',
  };

  try {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://cars.autotorgby.com/istoriya-prodazh-copart-iaai-manheim?VIN=$vin'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      print(body);

      var document = parse(body);

      var rows = document.querySelectorAll('table tbody tr');

      Map<String, String> vehicleData = {};

      for (var row in rows) {
        var cells = row.querySelectorAll('td');
        if (cells.length == 2) {
          String key = cells[0].text.trim();
          String value = cells[1].text.trim();
          vehicleData[key] = value;
        }
      }
      print(vehicleData);
    } else {
      print('reasonPhrase: :${response.reasonPhrase}');
    }
  } catch (e) {
    print('error: :$e');
  }
}

getI(htmlContent) {
  dom.Document document = parse(htmlContent);

  // Extract image URLs
  List<String> imageUrls = [];
  for (dom.Element img in document.querySelectorAll('a')) {
    imageUrls.add(img.attributes['data-href'] ?? '');
  }

  print(imageUrls);
}
