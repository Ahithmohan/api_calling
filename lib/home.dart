import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<Map<String, dynamic>> userList = [];
  // Map<String, dynamic>? user;
  void fetchUser() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/27"));
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json);
      setState(() {
        // user = json;
        userList.add(json);
        isLoading = false;
        print(userList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          fetchUser();
        },
        child: Text(
          "click",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userList.isNotEmpty) ...[
                  Text(userList[0]['userId'].toString()),
                  Text(userList[0]['title']),
                  Text("Completed :  ${userList[0]['completed'].toString()}"),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          userList.removeAt(0);
                        });
                      },
                      child: Text("delete"))
                ] else ...[
                  Text("no data available")
                ]
              ],
            )),
    );
  }
}
