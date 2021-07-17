import 'package:book_e_commerce/Authentication/authenication.dart';
import 'package:book_e_commerce/Config/config.dart';
import 'package:book_e_commerce/Store/myOrders.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            accountName: Text(EcommerceApp.sharedPreferences
                .getString(EcommerceApp.userName)),
            accountEmail: Text(EcommerceApp.sharedPreferences
                .getString(EcommerceApp.userEmail)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              backgroundImage: NetworkImage(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userAvatarUrl)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('My orders'),
            onTap: () {
              Route newRoute =
              MaterialPageRoute(builder: (_) => MyOrders());
              Navigator.pushReplacement(context, newRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              print('bh');
              EcommerceApp.auth.signOut().then((_) {
                Route newRoute =
                    MaterialPageRoute(builder: (_) => AuthenticScreen());
                Navigator.pushReplacement(context, newRoute);
              });
            },
          ),
        ],
      ),
    );
  }
}
