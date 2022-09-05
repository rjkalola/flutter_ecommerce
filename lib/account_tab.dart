import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  AccountTabState createState() => AccountTabState();
}

class AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Divider(
              color: Colors.black26,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 24, 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_account_tab.svg',
                    width: 22,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 24, 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_account_tab.svg',
                    width: 22,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Order",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 24, 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_account_tab.svg',
                    width: 22,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 24, 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_account_tab.svg',
                    width: 22,
                    color: Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 26, 24, 10),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
