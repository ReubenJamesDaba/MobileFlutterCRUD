import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/create.dart';
import 'package:flutter_crud/crud.dart';
import 'package:flutter_crud/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  
  @override
  _EditState createState() => _EditState();
     

}

class _EditState extends State<Edit> {
  late TextEditingController  firstname,
      lastname,
      middlename;
      List profile = List.filled(1, 0);
        String ipaddress = "192.168.10.15";

  String id = "";

  @override
  void initState() {
    getProfile();
    // firstname = new TextEditingController(text: profile[0]['FirstName']);
    // lastname = new TextEditingController(text: profile[0]['LastName']);
    // middlename = new TextEditingController(text: profile[0]['MiddleName']);
    // firebaseCloudMessaging_Listeners();
  }

  getProfile() async {
    
     SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('edit');
    var respose =
        await http.get("http://"+ipaddress+"/crud/Admin/event/edit?e="+id);
    if (respose.statusCode == 200) {

      setState(() {
        profile = json.decode(respose.body);
       
        
      });
      
      
    }
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
                      Color.fromARGB(255, 172, 128, 255),
                      Color.fromARGB(255, 200, 82, 255),
                      Color.fromARGB(255, 99, 15, 233),
                      Color.fromARGB(255, 33, 2, 92),
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
                      Text(
                        'REGISTER STUDENT',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      
                      _buildFirstNameTF(),
                      _buildLastNameTF(),
                      _buildMiddleNameTF(),
                      _buildCreateBtn(),
                      
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

    void _CreateStudent() async {
   

    var url =
        "http://"+ipaddress+"/crud/Admin/event/create";
    var data = {
      
      "FirstName": firstname.text,
      "LastName": lastname.text,
      "MiddleName": middlename.text
    
    };

    var res = await http.post(url, body: data);
    var datauser = json.decode(res.body);
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Crud()),
    );
  }
    Widget _buildCreateBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => _CreateStudent(),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xFFFF5252),
          child: Text(
            'REGISTER',
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

    Widget _buildFirstNameTF() {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First name',
          style: kLabelStyle,
        ),
        SizedBox(height: 12.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: firstname,
            style: TextStyle(
              color: Colors.red[400],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.red[400],
              ),
              hintText: 'First name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: lastname,
            style: TextStyle(
              color: Colors.red[400],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.red[400],
              ),
              hintText: 'Last Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Middle Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: middlename,
            style: TextStyle(
              color: Colors.red[400],
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.red[400],
              ),
              hintText: 'Midde Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

}
