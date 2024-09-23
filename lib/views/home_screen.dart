import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/models/app_data.dart';
import 'package:social_media_app/models/posts_model.dart';
import 'package:social_media_app/views/posts_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Instance of SingleTon Class
  // from app_data.dart
  AppData appData = AppData();
  Future<List<PostsModel>> fetchData() async {
    var dio = Dio();
    appData.postsList.clear();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    var data = response.data;

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        appData.postsList.add(PostsModel.fromJson(index));
      }
      return appData.postsList;
    } else {
      return appData.postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: appData.postsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsDetailsScreen(appData.postsList[index].userId),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: index % 2 == 0
                          ? Colors.deepPurple[100]
                          : Colors.lime[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("UserID: ${appData.postsList[index].userId}"),
                        Text("ID: ${appData.postsList[index].id}"),
                        Text(
                          "Title: ${appData.postsList[index].title}",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text("Body: ${appData.postsList[index].body}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          // Get.snackbar("Api Calling", "Navigating to Next Page");
          Get.defaultDialog(
            content: Text("Do you want to Fetch all Data"),
            confirm: TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PostsDetailsScreen(0),
                //   ),
                // );
                Get.to(PostsDetailsScreen(0));
              },
              child: Text("Confirm"),
            ),
            cancel: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
