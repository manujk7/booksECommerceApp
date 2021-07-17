import 'package:book_e_commerce/Config/config.dart';
import 'package:book_e_commerce/Widgets/customAppBar.dart';
import 'package:book_e_commerce/Widgets/customTextField.dart';
import 'package:book_e_commerce/modals/address.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  final _cName = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cFlatNumber = TextEditingController();
  final _cArea = TextEditingController();
  final _clandmark = TextEditingController();
  final _cCity = TextEditingController();
  final _cState = TextEditingController();
  final _cPincode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState.validate()) {
              final model = AddressModel(
                      name: _cName.text,
                      state: _cState.text,
                      pincode: _cPincode.text,
                      phoneNumber: _cPincode.text,
                      landmark: _clandmark.text,
                      flatNumber: _cFlatNumber.text,
                      city: _cCity.text,
                      area: _cArea.text)
                  .toJson();
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .doc(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .doc(DateTime.now().millisecondsSinceEpoch.toString())
                  .set(model)
                  .then((_) {
                final snackbar =
                    SnackBar(content: Text('Address added successfully'));
                scaffoldKey.currentState.showSnackBar(snackbar);
                FocusScope.of(context).requestFocus(FocusNode());
                formKey.currentState.reset();
              });
            }
          },
          label: Text('Done'),
          backgroundColor: Colors.deepPurple,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add address',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        hintText: 'Name',
                        controller: _cName,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'Phone Number',
                        controller: _cPhoneNumber,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'Flat Number',
                        controller: _cFlatNumber,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'Area',
                        controller: _cArea,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'Landmark',
                        controller: _clandmark,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'City',
                        controller: _cCity,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'State',
                        controller: _cState,
                        isObsecure: false,
                      ),
                      CustomTextField(
                        hintText: 'Pincode',
                        controller: _cPincode,
                        isObsecure: false,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const MyTextField({Key key, this.hint, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (value) => value.isEmpty ? 'Field can\'t be blank' : null,
      ),
    );
  }
}
