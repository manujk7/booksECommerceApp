import 'package:book_e_commerce/Store/addProduct.dart';
import 'package:book_e_commerce/Store/myOrders.dart';
import 'package:book_e_commerce/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:book_e_commerce/Config/config.dart';
import '../Widgets/myDrawer.dart';

double width;

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  String pageTitle = "Explore";
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = EcommerceApp.firestore;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    StoreHome(),
                    MyOrders(),
                    AddProduct()
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), topLeft: Radius.circular(0)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.home),
                  ),
                  label: "Explore",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.border_all),
                  ),
                  label: "My Orders",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add_box_rounded),
                  ),
                  label: "Add Product",
                ),
              ],
              currentIndex: selectedIndex,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              type: BottomNavigationBarType.fixed,
              // unselectedIconTheme: ColorNames.colorLightGrey,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              onTap: _onItemTapped,
              backgroundColor: Colors.black,
              elevation: 2,
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      getPageTitle(index);
      if (index == 1) {
      } else if (index == 2) {
      } else if (index == 3) {
      } else {}
    });
  }

  void getPageTitle(int index) {
    if (index == 0) {
      pageTitle = "Explore";
    } else if (index == 1) {
      pageTitle = "My Orders";
    } else if (index == 2) {
      pageTitle = "Add Product";
    }
  }
}

