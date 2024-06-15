

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key:key);

  @override 
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

   User? user ;
   String? token;


  @override
  void initState() {
    super.initState();
    getUserAndToken();
  }

    Future<void> getUserAndToken() async {
    user = Auth().currentUser;
    if (user != null) {
      token = await user!.getIdToken();
      setState(() {});
    }
  }
  Future<void> signOut() async {
    await Auth().signOut();
  }
 void copyTokenToClipboard() {
    if (token != null) {
      Clipboard.setData(ClipboardData(text: token!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token copied to clipboard')),
      );
    }
  }
  Widget _title() {
    return const Text('Home Page');
  }

  Widget _userUid() {
    return 
    Column(
      children: [    
        Text(user?.uid ?? 'usier id'),
        ElevatedButton(onPressed: copyTokenToClipboard, child: const Text('Copy token to Clipboardw'))
],
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut,
     child: const Text('Sign Out'));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity ,
        width:  double.infinity, 
        padding: const EdgeInsets.all(20),
        child : Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ])
      ) ,
    );
  }
}