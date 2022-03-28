import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/Profile.dart';
import 'package:flutter_crud/admin_event.dart';
import 'package:flutter_crud/admin_profile.dart';
import 'package:flutter_crud/event.dart';
import 'package:flutter_crud/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String id = "";
  String ipaddress = "192.168.10.15";
  String fullname = "";
  String contact = "";
  

  @override
  void initState() {
    getData();
   
  }



  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('displayName');
    var url = "http://"+ipaddress+"/crud/Student/event/view";

    var data = {
      "StudentID": id,
    };

    var res = await http.post(url, body: data);

    var datauser = json.decode(res.body);
    
    setState(() {
      fullname = datauser[0]['FullName'];
      contact = datauser[0]['Contact'];
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN - ESTUDYANTE TRACKER'),
        backgroundColor: Color.fromARGB(255, 56, 69, 240),
        leading: IconButton(
          icon: Icon(Icons.logout),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body:  SingleChildScrollView(
          padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
          child: Column(
            children: [
              Image.network('http://'+ipaddress+'/crud/assets/logos.png'),
              Divider(height: 60.0, color: Color.fromARGB(255, 7, 7, 7)),
              Text(
                fullname,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  padding: EdgeInsets.all(15),
                  color: Color.fromARGB(255, 233, 236, 248),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminProfile()),
                                        );
                                      },
                                      iconSize: 30.0,
                                      icon: const Icon(Icons.account_circle_outlined,
                                          color: Color.fromARGB(255, 82, 128, 255)),
                                      tooltip: 'SOS',
                                      
                                    ),
                                    Text('Profile',
                                        style: TextStyle(color: Color.fromARGB(255, 82, 128, 255))),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminEvent()),
                                      );
                                    },
                                    iconSize: 30.0,
                                    icon: const Icon(
                                        Icons.content_paste,
                                        color: Color.fromARGB(255, 82, 128, 255)),
                                    tooltip: 'Event',
                                  ),
                                  Text('Event',
                                      style: TextStyle(color: Color.fromARGB(255, 82, 128, 255))),
                                ],
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
