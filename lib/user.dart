import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List users;
  Map userData;
  Future setUser() async {
      String url = "https://reqres.in/api/users";
      http.Response response = await http.get(url);
      userData = json.decode(response.body);
        // debugPrint(response.body);
      setState(() {
        users = userData['data'];
      });
  }
  @override
  void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int i){
          final user = users[i];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                       backgroundImage: NetworkImage("${user["avatar"]}"),
                    ),
                  ),
                  Container(
                    child: Text("${user["first_name"]}",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    ),
                  ),
                ],
              )
            ),
          );
        }
      ),
    );
  }
}