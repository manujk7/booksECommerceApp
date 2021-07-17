import 'package:book_e_commerce/Config/config.dart';
import 'package:book_e_commerce/Widgets/customAppBar.dart';
import 'package:book_e_commerce/Widgets/customTextField.dart';
import 'package:book_e_commerce/Widgets/wideButton.dart';
import 'package:book_e_commerce/modals/address.dart';
import 'package:book_e_commerce/modals/book.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _cName = TextEditingController();
  final _cDate = TextEditingController();
  final _cStatus = TextEditingController();
  final _cAuthors = TextEditingController();
  final _cDescription = TextEditingController();
  final _cPrice = TextEditingController();
  final _cIsbn = TextEditingController();
  final _cPageCount = TextEditingController();
  final _cCategories = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // var menu = [
  //   {
  //     "title": "Unlocking Android",
  //     "isbn": "1933988673",
  //     "pageCount": 416,
  //     "publishedDate": {"date": "2009-04-01T00:00:00.000-0700"},
  //     "thumbnailUrl":
  //     "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson.jpg",
  //     "shortDescription":
  //     "Unlocking Android: A Developer's Guide provides concise, hands-on instruction for the Android operating system and development tools. This book teaches important architectural concepts in a straightforward writing style and builds on this with practical and useful examples throughout.",
  //     "longDescription":
  //     "Android is an open source mobile phone platform based on the Linux operating system and developed by the Open Handset Alliance, a consortium of over 30 hardware, software and telecom companies that focus on open standards for mobile devices. Led by search giant, Google, Android is designed to deliver a better and more open and cost effective mobile experience.    Unlocking Android: A Developer's Guide provides concise, hands-on instruction for the Android operating system and development tools. This book teaches important architectural concepts in a straightforward writing style and builds on this with practical and useful examples throughout. Based on his mobile development experience and his deep knowledge of the arcane Android technical documentation, the author conveys the know-how you need to develop practical applications that build upon or replace any of Androids features, however small.    Unlocking Android: A Developer's Guide prepares the reader to embrace the platform in easy-to-understand language and builds on this foundation with re-usable Java code examples. It is ideal for corporate and hobbyists alike who have an interest, or a mandate, to deliver software functionality for cell phones.    WHAT'S INSIDE:        * Android's place in the market      * Using the Eclipse environment for Android development      * The Intents - how and why they are used      * Application classes:            o Activity            o Service            o IntentReceiver       * User interface design      * Using the ContentProvider to manage data      * Persisting data with the SQLite database      * Networking examples      * Telephony applications      * Notification methods      * OpenGL, animation & multimedia      * Sample Applications  ",
  //     "status": "PUBLISH",
  //     "authors": ["W. Frank Ableson", "Charlie Collins", "Robi Sen"],
  //     "categories": ["Open Source", "Mobile"],
  //     "price": 200,
  //   },
  //   {
  //     "title": "Android in Action, Second Edition",
  //     "isbn": "1935182722",
  //     "pageCount": 592,
  //     "publishedDate": {"date": "2011-01-14T00:00:00.000-0800"},
  //     "thumbnailUrl":
  //     "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson2.jpg",
  //     "shortDescription":
  //     "Android in Action, Second Edition is a comprehensive tutorial for Android developers. Taking you far beyond \"Hello Android,\" this fast-paced book puts you in the driver's seat as you learn important architectural concepts and implementation strategies. You'll master the SDK, build WebKit apps using HTML 5, and even learn to extend or replace Android's built-in features by building useful and intriguing examples. ",
  //     "longDescription":
  //     "When it comes to mobile apps, Android can do almost anything   and with this book, so can you! Android runs on mobile devices ranging from smart phones to tablets to countless special-purpose gadgets. It's the broadest mobile platform available.    Android in Action, Second Edition is a comprehensive tutorial for Android developers. Taking you far beyond \"Hello Android,\" this fast-paced book puts you in the driver's seat as you learn important architectural concepts and implementation strategies. You'll master the SDK, build WebKit apps using HTML 5, and even learn to extend or replace Android's built-in features by building useful and intriguing examples. ",
  //     "status": "PUBLISH",
  //     "authors": ["W. Frank Ableson", "Robi Sen"],
  //     "categories": ["Java"],
  //     "price": 300,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Product',
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
                        textInputType: TextInputType.text,
                      ),
                      CustomTextField(
                        hintText: 'Status(Published)',
                        controller: _cStatus,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextField(
                        hintText: 'Authors',
                        controller: _cAuthors,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextField(
                        hintText: 'Description',
                        controller: _cDescription,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextField(
                        hintText: 'Price',
                        controller: _cPrice,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        hintText: 'Id',
                        controller: _cIsbn,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                      ),
                      CustomTextField(
                        hintText: 'Page Count',
                        controller: _cPageCount,
                        isObsecure: false,
                        textInputType: TextInputType.number,
                      ),
                      CustomTextField(
                        hintText: 'Publish Date',
                        controller: _cDate,
                        isObsecure: false,
                        textInputType: TextInputType.datetime,
                      ),
                      CustomTextField(
                        hintText: 'Categories',
                        controller: _cCategories,
                        isObsecure: false,
                        textInputType: TextInputType.text,
                      ),
                    ],
                  )),
              WideButton(
                onPressed: () {
                  final model = BookModel(
                      title: _cName.text,
                      isbn: _cIsbn.text,
                      pageCount: int.parse(_cPageCount.text),
                      publishedDate: PublishedDate(date: _cDate.text),
                      longDescription: _cDescription.text,
                      status: _cStatus.text,
                      price: int.parse(_cPrice.text),
                      authors: [_cAuthors.text],
                      categories: [_cCategories.text]).toJson();
                  EcommerceApp.firestore
                      .collection(EcommerceApp.collectionAllBooks)
                      .add(model)
                      .then((_) {
                    final snackbar =
                        SnackBar(content: Text('Product added successfully'));
                    scaffoldKey.currentState.showSnackBar(snackbar);
                    FocusScope.of(context).requestFocus(FocusNode());
                    formKey.currentState.reset();
                  });
                },
                message: "Add Product",
              )
            ],
          ),
        ),
      ),
    );
  }
}
