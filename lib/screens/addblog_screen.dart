import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireblogs/components/button.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final firestore = FirebaseFirestore.instance.collection('Blogs');

  final _formkey = GlobalKey<FormState>();

  String title = "";
  String desc = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter blog title' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter blog title',
                    labelText: 'Title',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descController,
                validator: (value) {
                  return value!.isEmpty ? 'Enter blog description' : null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter blog description',
                    labelText: 'Description',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                  title: 'Submit',
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      String id =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      firestore.doc(id).set({
                        'title': titleController.text.toString(),
                        'desc': descController.text.toString(),
                        'id': id
                      }).then((value) {
                        showToast('Your blog has been added');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((err) {
                        showToast(err.toString());
                      });
                    } else {
                      showToast('Provide blog details first');
                    }
                  })
            ],
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
