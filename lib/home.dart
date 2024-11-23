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
  List<dynamic> postData = [];
  void fetchPostData() async {
    const url = 'https://jsonplaceholder.typicode.com/comments?postId=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        postData = json;
        print(postData.length);
        isLoading = false;
      });
    } else {
      print("data fetch error${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: postData.length,
                itemBuilder: (context, index) {
                  final post = postData[index];
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      elevation: 7,
                      shadowColor: Colors.deepPurpleAccent,
                      color: Colors.lightGreenAccent,
                      child: ListTile(
                        title: Text(
                          post!["name"] ?? "no",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(post["body"]),
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            post["id"].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
