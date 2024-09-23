import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/app_data.dart';
import 'package:social_media_app/models/comments_model.dart';
import 'package:social_media_app/views/user_profile_screen.dart';

// ignore: must_be_immutable
class PostsDetailsScreen extends StatefulWidget {
  int postId;
  PostsDetailsScreen(this.postId, {super.key});

  @override
  State<PostsDetailsScreen> createState() => _PostsDetailsScreenState();
}

class _PostsDetailsScreenState extends State<PostsDetailsScreen> {
  //Fetching Data
  AppData appData = AppData();
  Future<List<CommentsModel>> fetchComments() async {
    appData.commentsList.clear();
    Dio dio = Dio();
    var response;
    if (widget.postId != 0) {
      response = await dio.get("https://jsonplaceholder.typicode.com/comments",
          queryParameters: {'postId': widget.postId});
    } else {
      response = await dio.get("https://jsonplaceholder.typicode.com/comments");
    }
    var data = response.data;
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        appData.commentsList.add(CommentsModel.fromJson(index));
      }
      return appData.commentsList;
    } else {
      return appData.commentsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts Details"),
      ),
      body: FutureBuilder(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: appData.commentsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                              appData.commentsList[index].postId),
                        ));
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
                        Text("PostID: ${appData.commentsList[index].postId}"),
                        Text("Id: ${appData.commentsList[index].id}"),
                        Text(
                          "Name: ${appData.commentsList[index].name}",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text("Email: ${appData.commentsList[index].email}"),
                        Text("Body: ${appData.commentsList[index].body}"),
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
     
    );
  }
}
