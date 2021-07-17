import 'package:book_e_commerce/Widgets/customAppBar.dart';
import 'package:book_e_commerce/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_e_commerce/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: MyAppBar(
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .doc(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.collectionOrders).snapshots(),
              builder: (_, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (_, index) {
                          return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('books')
                                  .where('isbn',
                                      whereIn: snapshot.data.docs[index]
                                          .get(EcommerceApp.productID))
                                  .get(),
                              builder: (_, snap) {
                                return snap.hasData?OrderCard(
                                  itemCount: snap.data.docs.length,
                                  data: snap.data.docs,
                                  orderID: snapshot.data.docs[index].id
                                ): Center(child: LoadingWidget());
                              });
                        })
                    : Center(child: LoadingWidget());
              })),
    );
  }
}
