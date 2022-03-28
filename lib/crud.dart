import 'package:flutter/material.dart';
import 'package:flutter_crud/create.dart';
import 'package:flutter_crud/edit.dart';
import 'package:flutter_crud/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Crud extends StatefulWidget {
  const Crud({ Key? key }) : super(key: key);

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  String id = "";
  String ipaddress = "192.168.10.15";
  String firstname = "";
  String lastname = "";
  String middlename = "";
  List profile = List.filled(1, 0);
  @override
  void initState() {
    getAllProfile();
    // firebaseCloudMessaging_Listeners();
  }

  getAllProfile() async {
    var respose =
        await http.get("http://"+ipaddress+"/crud/Admin/event/view");
    if (respose.statusCode == 200) {
      setState(() {
        profile = json.decode(respose.body);
      });
      
      return profile;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
          child: Column(
            children: [
              Divider(height: 200.0),
              Image.network('http://192.168.10.15/crud/assets/logos.png'),
              Divider(height: 60.0),
              RaisedButton(
        elevation: 5.0,
        onPressed: () => userSignIn(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromARGB(255, 9, 5, 247),
        child: Text(
          'GET STARTED',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
              
             
            ],
          ),
        ),
    );
  }

  _EditStudent(profile) async {
   
    SharedPreferences pref = await SharedPreferences.getInstance();
      pref.getString(
        'edit',
      );
      pref.setString('edit', profile);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Edit()),
    );
  }

  void userSignIn() async {
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ); 
  }

}