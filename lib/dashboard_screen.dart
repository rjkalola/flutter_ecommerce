import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/home_tab.dart';
import 'package:flutter_ecommerce/signup_screen.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
    Text(
      'Index 4: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Home'),
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset('assets/images/ic_home_tab.svg',
                    width: 20),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                    'assets/images/ic_home_tab_inactive.svg',
                    width: 20),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset('assets/images/ic_search_tab.svg',
                    width: 22),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                    'assets/images/ic_search_tab_inactive.svg',
                    width: 22),
              ),
              label: 'Explore'),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset('assets/images/ic_cart_tab.svg',
                    width: 22),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                    'assets/images/ic_cart_tab_inactive.svg',
                    width: 22),
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset('assets/images/ic_offer_tab.svg',
                    width: 22),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                    'assets/images/ic_offer_tab_inactive.svg',
                    width: 22),
              ),
              label: 'Offer'),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset('assets/images/ic_account_tab.svg',
                    width: 22),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                    'assets/images/ic_account_tab_inactive.svg',
                    width: 22),
              ),
              label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.black38,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        onTap: _onItemTapped,
      ),
    );
  }
}
