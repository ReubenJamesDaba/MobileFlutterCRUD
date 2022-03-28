import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/admin_event.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_crud/login.dart';
import 'package:flutter_crud/upload.dart';
import 'dart:convert';

import 'package:flutter_crud/utilities/constants.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class EventCreate extends StatefulWidget {
  @override
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  bool isChecked = false;

  late TextEditingController eventname,
      detail;
  bool processing = false;
  String ipaddress = "192.168.10.15";
  @override
  void initState() {
    super.initState();
    eventname = new TextEditingController();
    detail = new TextEditingController();
   
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Event Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: eventname,
            style: TextStyle(
              color: Color.fromARGB(255, 10, 41, 219),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 67, 23, 226),
              ),
              hintText: 'Event Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Details',
          style: kLabelStyle,
        ),
        SizedBox(height: 12.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: detail,
            style: TextStyle(
              color: Color.fromARGB(255, 10, 41, 219),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 10, 41, 219),
              ),
              hintText: 'Details',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => userSignIn(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromARGB(255, 10, 41, 219),
        child: Text(
          'CREATE EVENT',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });

    var url =
        "http://"+ipaddress+"/crud/Event/create";
    var data = {
      "EventName": eventname.text,
      "EventDetails": detail.text,
     
    };

    var res = await http.post(url, body: data);
  
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminEvent()),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network('http://'+ipaddress+'/crud/assets/logos.png'),
                      SizedBox(
                        height: 70.0,
                      ),
                      Text(
                        'EVENT',
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 6, 255),
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildEmailTF(),
                      
                      _buildFirstNameTF(),
                   
                    
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}
