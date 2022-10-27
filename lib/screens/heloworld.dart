import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class helloword extends StatefulWidget {
  const helloword({Key? key}) : super(key: key);

  @override
  State<helloword> createState() => _hellowordState();
}

class _hellowordState extends State<helloword> {
  Future fetchnheloword() async {
    final response = await http.get(Uri.parse(
        'https://sandbox.api.service.nhs.uk/hello-world/hello/world'));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: Text(
            "print",
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            fetchnheloword();
          },
          style: TextButton.styleFrom(
              // backgroundColor: Colors.red,
              elevation: 2,
              backgroundColor: Colors.amber),
        ),
      ],
    );
  }
}
