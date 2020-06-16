import 'package:flutter/material.dart';
import 'package:marketplace/authentication/sign_in.dart';
import 'package:marketplace/drawer/drawer.dart';
import 'package:marketplace/drawer/my_account.dart';
import 'package:marketplace/screens/buy_page.dart';
import 'package:marketplace/screens/donation_page.dart';
import 'package:marketplace/screens/sell_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<dynamic> _widgetOptions = <Widget>[
    Buy(),
    MyProducts(),
    Donation(),
    MyAccount(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            title: Text('Sell'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Donate'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Rent'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}
