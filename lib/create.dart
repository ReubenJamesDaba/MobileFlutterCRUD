import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/crud.dart';
import 'package:flutter_crud/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Create extends StatefulWidget {
  const Create({ Key? key }) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String id = "";
  String ipaddress = "192.168.10.15";
  
  late TextEditingController  firstname,
      lastname,
      middlename;
       bool processing = false;


  @override
  void initState() {
    firstname = new TextEditingController();
    lastname = new TextEditingController();
    middlename = new TextEditingController();
    getData();
    // firebaseCloudMessaging_Listeners();
  }

  getData() async {
    
    var url = "http://"+ipaddress+"/crud/Admin/event/edit/";

    var res = await http.post(url, body: null);

    var datauser = json.decode(res.body);
    print(datauser[0]['FirstName']);
    setState(() {
      firstname = datauser[0]['FirstName'];
      lastname = datauser[0]['LastName'];
      middlename = datauser[0]['MiddleName'];
      
    });
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
                      Color(0xFFFF8A80),
                      Color(0xFFFF5252),
                      Color(0xFFFF1744),
                      Color(0xFFD50000),
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
    setState(() {
      processing = true;
    });

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