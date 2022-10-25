import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireblogs/screens/addblog_screen.dart';
import 'package:fireblogs/screens/option_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        title: Text('All Blogs'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddBlogScreen()));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showToast('You have been logged out');
                auth.signOut().then(
                  (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OptionScreen(),
                    ));
                  },
                );
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text((index + 1).toString()),
                title: Text('Fire Blogs'),
                subtitle: Text(
                    'This is an amazing blog. I hope you guys like it and also dont forget to give us a feedback'),
                trailing: Text('Bishnudev Khutia'),
              );
            },
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.blue,
      fontSize: 16.0,
    );
  }
}
