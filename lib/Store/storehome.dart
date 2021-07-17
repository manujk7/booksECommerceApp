import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_e_commerce/Store/product_page.dart';
import 'package:book_e_commerce/notifiers/cartitemcounter.dart';
import 'package:book_e_commerce/Config/light_color.dart';
import 'package:book_e_commerce/Config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:book_e_commerce/Config/config.dart';
import '../Widgets/customAppBar.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../modals/book.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = EcommerceApp.firestore;

    // var menu = [
    //   {
    //     "title": "Unlocking Android",
    //     "isbn": "1933988673",
    //     "pageCount": 416,
    //     "publishedDate": {"date": "2009-04-01T00:00:00.000-0700"},
    //     "thumbnailUrl":
    //         "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson.jpg",
    //     "shortDescription":
    //         "Unlocking Android: A Developer's Guide provides concise, hands-on instruction for the Android operating system and development tools. This book teaches important architectural concepts in a straightforward writing style and builds on this with practical and useful examples throughout.",
    //     "longDescription":
    //         "Android is an open source mobile phone platform based on the Linux operating system and developed by the Open Handset Alliance, a consortium of over 30 hardware, software and telecom companies that focus on open standards for mobile devices. Led by search giant, Google, Android is designed to deliver a better and more open and cost effective mobile experience.    Unlocking Android: A Developer's Guide provides concise, hands-on instruction for the Android operating system and development tools. This book teaches important architectural concepts in a straightforward writing style and builds on this with practical and useful examples throughout. Based on his mobile development experience and his deep knowledge of the arcane Android technical documentation, the author conveys the know-how you need to develop practical applications that build upon or replace any of Androids features, however small.    Unlocking Android: A Developer's Guide prepares the reader to embrace the platform in easy-to-understand language and builds on this foundation with re-usable Java code examples. It is ideal for corporate and hobbyists alike who have an interest, or a mandate, to deliver software functionality for cell phones.    WHAT'S INSIDE:        * Android's place in the market      * Using the Eclipse environment for Android development      * The Intents - how and why they are used      * Application classes:            o Activity            o Service            o IntentReceiver       * User interface design      * Using the ContentProvider to manage data      * Persisting data with the SQLite database      * Networking examples      * Telephony applications      * Notification methods      * OpenGL, animation & multimedia      * Sample Applications  ",
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
    //         "https://s3.amazonaws.com/AKIAJC5RLADLUMVRPFDQ.book-thumb-images/ableson2.jpg",
    //     "shortDescription":
    //         "Android in Action, Second Edition is a comprehensive tutorial for Android developers. Taking you far beyond \"Hello Android,\" this fast-paced book puts you in the driver's seat as you learn important architectural concepts and implementation strategies. You'll master the SDK, build WebKit apps using HTML 5, and even learn to extend or replace Android's built-in features by building useful and intriguing examples. ",
    //     "longDescription":
    //         "When it comes to mobile apps, Android can do almost anything   and with this book, so can you! Android runs on mobile devices ranging from smart phones to tablets to countless special-purpose gadgets. It's the broadest mobile platform available.    Android in Action, Second Edition is a comprehensive tutorial for Android developers. Taking you far beyond \"Hello Android,\" this fast-paced book puts you in the driver's seat as you learn important architectural concepts and implementation strategies. You'll master the SDK, build WebKit apps using HTML 5, and even learn to extend or replace Android's built-in features by building useful and intriguing examples. ",
    //     "status": "PUBLISH",
    //     "authors": ["W. Frank Ableson", "Robi Sen"],
    //     "categories": ["Java"],
    //     "price": 300,
    //   },
    // ];
    //
    // menu.forEach((obj) {
    //   db.collection(EcommerceApp.collectionAllBooks).add({
    //     "title": obj["title"],
    //     "isbn": obj["isbn"],
    //     "pageCount": obj["pageCount"],
    //     "publishedDate": obj["publishedDate"],
    //     "thumbnailUrl": obj["thumbnailUrl"],
    //     "shortDescription": obj["shortDescription"],
    //     "longDescription": obj["longDescription"],
    //     "status": obj["status"],
    //     "authors": obj["authors"],
    //     "categories": obj["categories"],
    //     "price": obj["price"],
    //   }).then((docRef) {
    //     print("Document written with ID: $docRef");
    //   }).catchError(print);
    // });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: MyAppBar(),
            ),
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('books').snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? SliverToBoxAdapter(
                          child: Center(child: LoadingWidget()),
                        )
                      : SliverStaggeredGrid.countBuilder(
                          crossAxisCount: 1,
                          staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            BookModel model = BookModel.fromJson(
                                snapshot.data.docs[index].data());
                            return sourceInfo(model, context);
                          },
                          itemCount: snapshot.data.docs.length,
                        );
                }),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(BookModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (_) => ProductPage(bookModel: model));
      Navigator.push(context, route);
    },
    splashColor: LightColor.purple,
    child: Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child:
                  card(primaryColor: background, imgPath: model.thumbnailUrl),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.title,
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.pageCount.toString(),
                          style: TextStyle(
                            color: LightColor.grey,
                            fontSize: 14,
                          )),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      alignment: Alignment.topLeft,
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "50%",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "OFF",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text("M.R.P.: ₹",
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: LightColor.grey,
                                  )),
                              Text("1500.0",
                                  style: AppTheme.h6Style.copyWith(
                                      fontSize: 14,
                                      color: LightColor.grey,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Price: ",
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: LightColor.grey,
                                  )),
                              Text(
                                "₹",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              Text(model.price.toString(),
                                  style: AppTheme.h6Style.copyWith(
                                    fontSize: 14,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Flexible(
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: removeCartFunction == null
                      ? IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: LightColor.purple,
                          ),
                          onPressed: () {
                            checkItemInCart(model.isbn, context);
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart,
                            color: LightColor.purple,
                          ),
                          onPressed: () {
                            print('StoreHome.dart');
                            removeCartFunction();
                            //checkItemInCart(model.isbn, context);
                          }),
                ),
                Divider(
                  height: 4,
                )
              ],
            ))
          ],
        )),
  );
}

Widget _chip(String text, Color textColor,
    {double height = 0, bool isPrimaryCard = false}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Chip(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      label: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
      height: 150,
      width: width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: imgPath != null && imgPath.isNotEmpty
            ? Image.network(
                imgPath,
                height: 150,
                width: width * .34,
                fit: BoxFit.fill,
              )
            : Image.network(
                "https://www.seekpng.com/png/detail/510-5101967_book-png-tumblr-cute.png",
                height: 150,
                width: width * .34,
                fit: BoxFit.fill,
              ),
      ));
}

void checkItemInCart(String productID, BuildContext context) {
  print(productID);

  ///print(cartItems);
  EcommerceApp.sharedPreferences
          .getStringList(
            EcommerceApp.userCartList,
          )
          .contains(productID)
      ? Fluttertoast.showToast(msg: 'Product is already in cat')
      : addToCart(productID, context);
}

void addToCart(String productID, BuildContext context) {
  List temp = EcommerceApp.sharedPreferences.getStringList(
    EcommerceApp.userCartList,
  );
  temp.add(productID);
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .update({EcommerceApp.userCartList: temp}).then((_) {
    Fluttertoast.showToast(msg: 'Item Added Succesfully');
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, temp);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
