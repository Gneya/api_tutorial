import 'dart:convert';

import 'package:api_tutorial/modals/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModal> userList = [];
  Future<List<UserModal>> getUser() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModal.fromJson(i));
      }
    }

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API COURSE"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: Text(userList[index].address!.city.toString()),
                  );
                }));
          },
        ),
      ),
    );
  }
}
