import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> getData() async {
    var url = Uri.https('official-joke-api.appspot.com', 'random_joke');
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var joke = jsonDecode(response.body);
      return joke;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                return Text(
                  '${data['setup']}----${data['punchline']}',
                  style: TextStyle(fontSize: 50),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        ElevatedButton(
          onPressed: () {
            setState(() {});
          },
          child: Text(
            'NextJoke',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(200, 50)),
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            backgroundColor: MaterialStateProperty.all(Colors.cyan),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
          ),
        )
      ],
    );
  }
}
