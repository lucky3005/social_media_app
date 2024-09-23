import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/app_data.dart';
import 'package:social_media_app/models/user_model.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatefulWidget {
  int id;
  UserProfileScreen(this.id, {super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  AppData appData = AppData();
  Future<void> fetchUsers() async {
    Dio dio = Dio();
    // appData.userData = "";
    var response = await dio
        .get("https://jsonplaceholder.typicode.com/users/${widget.id}");
    var data = response.data;
    if (response.statusCode == 200) {
      // for (Map<String, dynamic> index in data) {
      //   appData.usersList.add(UsersModel.fromJson(index));
      // }
      appData.userData = UsersModel.fromJson(data);
      return appData.userData;
    } else {
      return appData.userData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: widget.id % 2 == 0
                          ? Colors.deepPurple[100]
                          : Colors.lime[100],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Id-- ${appData.userData.id}"),
                    Text("Name-- ${appData.userData.name}"),
                    Text("User Name-- ${appData.userData.username}"),
                    Text("E-Mail-- ${appData.userData.email}"),
                    Text("Address Street-- ${appData.userData.address.street}"),
                    Text("Address Suit-- ${appData.userData.address.suite}"),
                    Text("Address City-- ${appData.userData.address.city}"),
                    Text(
                        "Address Zip Code-- ${appData.userData.address.zipcode}"),
                    Text(
                        "Address Geo Latitutde-- ${appData.userData.address.geo.lat}"),
                    Text(
                        "Address Geo Longitude-- ${appData.userData.address.geo.lng}"),
                    Text("Phone-- ${appData.userData.phone}"),
                    Text("Website-- ${appData.userData.website}"),
                    Text("Company Name-- ${appData.userData.company.name}"),
                    Text(
                        "Company Catch Phrase-- ${appData.userData.company.catchPhrase}"),
                    Text("Company Catch Bs-- ${appData.userData.company.bs}"),
                  ],
                ),
              ),
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
