import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/admin.dart';
import 'package:flutter_crud/create_event.dart';
import 'package:flutter_crud/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AdminEvent extends StatefulWidget {
  @override
  _AdminEventState createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  List profile = List.filled(1, 0);
  String id = "";
    String ipaddress = "192.168.10.15";

  getAllProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('displayName');
    var respose =
        await http.get("http://"+ipaddress+"/crud/Event/getevent/"+id);
    if (respose.statusCode == 200) {
      setState(() {
        profile = json.decode(respose.body);
      });
      print(profile);
      return profile;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
        backgroundColor:
            Color.fromARGB(255, 80, 96, 239), // we show the progress in the title...
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Admin()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.create), 
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventCreate()),
            );
            }
          ),

         
        ],
      ),
      body: ListView.builder(
          itemCount: profile.length,
          itemBuilder: (context, index) {
            
            return Container(
              child: ListTile(
                leading: Text(profile[index]['EventID']),
                title: Text(profile[index]['EventName']),
                subtitle: Text(profile[index]['EventDetails']),
                trailing: FloatingActionButton(
                    onPressed: () => _AddStudent(profile[index]['Evn']), //profile[index]['StudentID']
                    child: Text('Delete')),
              ),
            );
          }),
    );
  }
      void _AddStudent(Events) async {
  
    var url =
        "http://"+ipaddress+"/crud/Event/delete";
    var data = {
      "EventID": Events,
    
    };

   await http.post(url, body: data);
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminEvent()),
    );
  }
}


