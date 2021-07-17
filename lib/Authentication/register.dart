import 'dart:io';
import 'package:book_e_commerce/Widgets/customTextField.dart';
import 'package:book_e_commerce/dialogs/errorDialog.dart';
import 'package:book_e_commerce/dialogs/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:book_e_commerce/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final TextEditingController _nameController = TextEditingController();

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  String userPhotoUrl = "";
  File _image;

  Future<void> _pickImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      showDialog(
          context: context,
          builder: (v) {
            return ErrorAlertDialog(
              message: "Please pick an photo",
            );
          });
    } else {
      _passwordController.text == _passwordConfirmController.text
          ? _emailController.text.isNotEmpty &&
                  _passwordConfirmController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty
              ? upload()
              : showMyDialog('Please fill the desired fields')
          : showMyDialog('Password doesn\'t match');
    }
  }

  upload() async {
    showDialog(
        context: context,
        builder: (_) {
          return LoadingAlertDialog();
        });
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage reference = FirebaseStorage.instance;
    Reference ref = reference.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) {
        userPhotoUrl = value;
        print(userPhotoUrl);
        _register();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.red,fontSize: 24),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: _screenWidth * 0.15,
                  backgroundColor: Colors.white,
                  backgroundImage: _image == null ? null : FileImage(_image),
                  child: _image == null
                      ? Icon(
                          Icons.person_add,
                          size: _screenWidth * 0.15,
                          color: Colors.grey,
                        )
                      : null,
//                        backgroundImage: _image == null
//                            ? AssetImage('assets/images/loading.png')
//                            : FileImage(_image)
                )),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person_outline,
                    controller: _nameController,
                    hintText: 'Name',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.person_outline,
                    controller: _emailController,
                    hintText: 'Email',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock_outline,
                    controller: _passwordController,
                    hintText: 'Password',
                    isObsecure: true,
                  ),
                  CustomTextField(
                    data: Icons.lock_outline,
                    controller: _passwordConfirmController,
                    hintText: 'Confirm passsword',
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                uploadImage();
              },
              color: Colors.green,
              child: Text(
                'Sign up',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 3,
              width: _screenWidth * 0.8,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    User currentUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      writeDataToDataBase(currentUser).then((s) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future writeDataToDataBase(User currentUser) async {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(currentUser.uid)
        .set({
      EcommerceApp.userUID: currentUser.uid,
      EcommerceApp.userEmail: currentUser.email,
      EcommerceApp.userName: _nameController.text,
      EcommerceApp.userAvatarUrl: userPhotoUrl
    });
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userUID, currentUser.uid);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ['garbageValue']);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, currentUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameController.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userPhotoUrl);
  }

  showMyDialog(String message) {
    showDialog(
        context: context,
        builder: (con) {
          return ErrorAlertDialog(
            message: message,
          );
        });
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
