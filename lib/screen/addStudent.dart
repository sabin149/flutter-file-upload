import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '/http/httpstudent.dart';

import '/model/student.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formkey = GlobalKey<FormState>();
  File? _image;

  String fname = '';
  int age = 0;
  String gender = '';
  String add = '';

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  //method to open image from gallery
  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Add Student'),
      ), 
      body: SizedBox( 
        height: 580, 
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    // color: Colors.amberAccent,
                    alignment: Alignment.center,
                    child: const Text(
                      'Add Student Information',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: 5.0),
                    ),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image == null
                            ? const AssetImage('images/profile_image.png')
                                as ImageProvider
                            : FileImage(_image!),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => bottomSheet());
                          },
                          child: const Icon(
                            Icons.upload,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onSaved: (value) {
                      fname = value!;
                    },
                    validator: RequiredValidator(errorText: "required field" ) ,
                    // maxLength: 30,
                    decoration: const InputDecoration(
                        labelText: 'FullName:',
                        hintText: 'Enter your fullname',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(errorText: "required field" ) ,
                    onSaved: (newValue) {
                      age = int.parse(newValue!);
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Age:',
                        hintText: 'Enter your age',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(errorText: "required field" ) ,
                    onSaved: (newValue) {
                      gender = newValue!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Gender:',
                        hintText: 'Enter your gender',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: RequiredValidator(errorText: "required field" ) ,
                    onSaved: (newValue) {
                      add = newValue!;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Address:',
                        hintText: 'Enter your address:',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
              
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      _formkey.currentState!.save();
                      Student student = Student(
                          fullname: fname,
                          age: age,
                          gender: gender,
                          address: add);
                      HttpConnectStudent().registerStudentPosts(student, _image);
      
                      _formkey.currentState!.reset();
                      Navigator.pushNamed(context, '/displaystudent');
                    },
                    child: const Text('Add Student'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/displaystudent');
      
                    },
                    child: const Text('View Student'),
                  ),
                ],
              )),
        ),
      ),
    );
  }

//widget to build a bottomsheet for image
  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Choose profile photo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

