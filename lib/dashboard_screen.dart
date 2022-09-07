import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/account_tab.dart';
import 'package:flutter_ecommerce/categories_tab.dart';
import 'package:flutter_ecommerce/home_tab.dart';
import 'package:flutter_ecommerce/offer_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  String title = "";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _screens = <Widget>[
    HomeTab(),
    CategoriesTab(),
    Center(child: Text("Cart Info")),
    OfferTab(),
    AccountTab(),
  ];
  static const List<String> titles = <String>[
    "Home",
    "Explore",
    "Cart",
    "Offer",
    "Account"
  ];

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex.toString());
      print(titles.elementAt(_selectedIndex));
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
        title: Text(titles.elementAt(_selectedIndex),style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        )),
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
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
