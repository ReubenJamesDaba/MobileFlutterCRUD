import 'package:flutter/material.dart';
import 'package:flutter_crud/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id = "";
  String fullname = "";
 
  String contact = "";
  String image = "";
    String ipaddress = "192.168.10.15";

  @override
  void initState() {
    getData();
    // firebaseCloudMessaging_Listeners();
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('displayName');
    print(id);
    var url = "http://"+ipaddress+"/crud/Student/profile/"+id;

    var data = {
      "StudentID": id,
    };

    var res = await http.post(url, body: data);

    var datauser = json.decode(res.body);
    print(datauser);
    print(url);
    print(id);
    print("hello");
    setState(() {
      fullname = datauser[0]['FullName'];
      image = datauser[0]['Image'];
      contact = datauser[0]['Contact'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor:
            Color.fromARGB(255, 80, 96, 239), // we show the progress in the title...
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network('http://'+ipaddress+'/crud/assets/profile/' + image),
              Divider(height: 60.0, color: Color.fromARGB(255, 99, 75, 235)),
              Text(
                fullname,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              
              Text(
                contact,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
