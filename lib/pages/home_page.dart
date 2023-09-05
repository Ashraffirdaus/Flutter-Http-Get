import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declare a late variable to store the API response as a string
  String stringResponse = "";
  Map mapResponse = {};
  Map dataResponse = {};
  List dataListApi = [];
// Define an asynchronous function to make an API call
  Future<void> apicall() async {
    // Declare a variable to store the HTTP response
    http.Response response;
    try {
      response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // If the response is successful, update the widget's state
        setState(() {
          // stringResponse = response.body;
          dataResponse = jsonDecode(response.body);
          // dataResponse = mapResponse["data"];
          dataListApi = dataResponse["data"];
        });
      }
    } catch (error) {
      print("API request failed: $error");
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Api Demo"),
        ),
        body: ListView.builder(
            itemCount: dataListApi.length,
            itemBuilder: ((context, index) {
              return Container(
                child: Column(
                  children: [
                    Image.network(
                      dataListApi[index]["avatar"],
                    ),
                    Text(dataListApi[index]["id"].toString()),
                    Text(dataListApi[index]["email"].toString()),
                    Text(dataListApi[index]["first_name"].toString()),
                    Text(dataListApi[index]["last_name"].toString()),
                  ],
                ),
              );
            })));
  }
}
