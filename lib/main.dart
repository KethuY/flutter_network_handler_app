import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new NetworkApp());

class NetworkApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new NetworkScreen(),
    );
  }
}

class NetworkScreen extends StatefulWidget {
  @override
  _NetworkScreenState createState() => new _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {

  List widgets=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Posts'),
      ),
      body: new ListView.builder(itemBuilder: (BuildContext context,int position){
        return getRow(position);
      },
        itemCount: widgets.length,
      )
    );
  }

   getData() async {

    String url="https://jsonplaceholder.typicode.com/posts";
    http.Response response=await http.get(url);
    setState(() {
      if (response.body!=null) {
        widgets = json.decode(response.body);
      }
    });
   }

  Widget getRow(int position) {
    return new Padding(padding: const EdgeInsets.all(8.0),
    child: new Text("${position}.${widgets[position]["title"]}"),
    );

  }

}

