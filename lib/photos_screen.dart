import 'dart:convert';

import 'package:api_tutorial/modals/photos_modals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  List<PhotosModals> photoList = [];
  Future<List<PhotosModals>> getPhotos() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      photoList.clear();
      for (Map i in data) {
        photoList.add(PhotosModals.fromJson(i));
      }
    }
    return photoList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API COURSE"),
      ),
      body: FutureBuilder(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2),
              itemBuilder: (context, index) {
                print(photoList.length);
                return Image.network(photoList[index].url.toString());
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
