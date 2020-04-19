import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
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

  final List<Widget> pages = [
    HomePage(),
    CollectionPage(),
    CollectionPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
      onTap: (int index) {
//        if (index == 2) {
//          Navigator.of(context).push(MaterialPageRoute(
//              builder: (context) => CartPage(
//                    productRepository: ProductRepository(),
//                  )));
//        } else {
        setState(() {
          _selectedIndex = index;
        });
//        }
      },
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xff5257f5),
      type: BottomNavigationBarType.shifting,
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
    return Scaffold(
        appBar: AppBar(
          brightness: ThemeData.estimateBrightnessForColor(Colors.grey),
          elevation: 0.0,
        ),
        body: PageStorage(
          child: pages[_selectedIndex],
          bucket: bucket,
        ),
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex));
  }
}
