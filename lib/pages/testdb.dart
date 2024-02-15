import 'package:flutter/material.dart';
import 'package:banco_alimentos/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '/services/firebase_service.dart';

class TestDBPage extends StatefulWidget {
  @override
  _TestDBPageState createState() => _TestDBPageState();
}

class _TestDBPageState extends State<TestDBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestDB Page'),
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List? usuarios = snapshot.data;
            return ListView.builder(
              itemCount: usuarios?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Usuario ${index + 1}'),
                  subtitle: Text('Data: ${usuarios?[index]}'),
                );
              },
            );
          }
        },
      ),
    );
  }

}