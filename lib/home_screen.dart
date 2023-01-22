import 'dart:convert';
import 'dart:ui';

import 'package:api_tutorial/modals/post_modals/post_modals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<PostModals> postList = [];
  Future<List<PostModals>> getPostApi() async {
    print("hello");
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        print(i.toString());
        postList.add(PostModals.fromJson(i));
      }
      print("Done");
      return postList;
    } else {
      return postList;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API COURSE"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: ((context, index) {
                          return Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(postList[index].title.toString()),
                              Text(
                                "Description",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(postList[index].body.toString()),
                            ],
                          ));
                        }));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
