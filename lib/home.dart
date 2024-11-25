import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> product = [];
  void fetchProduct() async {
    const url = "https://dummyjson.com/products";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        print(json);
        setState(() {
          product = json['products'];
          print(product);
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: product.length,
      itemBuilder: (context, index) {
        final data = product[index];
        return Card(
          color: Colors.greenAccent,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(
                        data['id'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      data?["title"] ?? "gg",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Text(data["description"] ?? "des"),
              ],
            ),
          ),
        );
      },
    ));
  }
}
