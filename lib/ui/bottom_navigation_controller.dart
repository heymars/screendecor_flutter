import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_decor/ui/collection/collection_page.dart';

import 'home/home_page.dart';

class BottomNavigationBarController extends StatefulWidget {
//  final Store<List<CartModel>> store;

  BottomNavigationBarController();

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController>
    with SingleTickerProviderStateMixin {
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final PageStorageBucket bucket = PageStorageBucket();
  HomePage homePage;
  CollectionPage collectionPage;
  List<Widget> pages;
  Widget currentPage;
  int _selectedIndex = 0;
  @override
  void initState() {
    homePage = HomePage(
      key: keyOne,
    );
    collectionPage = CollectionPage(key: keyTwo);
    collectionPage = CollectionPage(
      key: keyTwo,
    );
    pages = [homePage, collectionPage, collectionPage];
    currentPage = homePage;
    super.initState();
  }

  var items = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home),
        title: Text(
          'Home',
          style: TextStyle(
              fontFamily: 'Poppins-SemiBold', fontSize: 11, letterSpacing: 0.1),
        )),
    new BottomNavigationBarItem(
        icon: Icon(Icons.collections),
        activeIcon: Icon(Icons.collections),
        title: Text(
          'Collection',
          style: TextStyle(
              fontFamily: "Poppins-SemiBold", fontSize: 11, letterSpacing: 0.1),
        )),
    new BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        activeIcon: Icon(Icons.favorite),
        title: Text(
          'Favourite',
          style: TextStyle(
              fontFamily: 'Poppins-SemiBold', fontSize: 11, letterSpacing: 0.1),
        )),
  ];

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          currentPage = pages[index];
        });
//        }
      },
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xff000000),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Color(0xff9c9c9c),
      selectedLabelStyle: TextStyle(fontFamily: "Poppins-Bold", fontSize: 12),
      unselectedLabelStyle: TextStyle(fontFamily: "Poppins-Bold", fontSize: 12),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      items: items);
//  Widget _bottomNavigationBar(int selectedIndex) => BottomNavyBar(
//        selectedIndex: _selectedIndex,
//        backgroundColor: Colors.white,
//        items: items,
//        onItemSelected: (int value) {
//          setState(() {
//            _selectedIndex = value;
//          });
//        },
//      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return Scaffold(
//        appBar: AppBar(
//          brightness: ThemeData.estimateBrightnessForColor(Colors.grey),
//          elevation: 0.0,
//        ),
        body: PageStorage(
          child: currentPage,
          bucket: bucket,
        ),
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex));
  }
}
