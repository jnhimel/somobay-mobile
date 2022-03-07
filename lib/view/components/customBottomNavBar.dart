import 'package:flutter/material.dart';

import '../dashboard_screen.dart';
import '../deposits_screen.dart';
import '../loans_screen.dart';
import '../profile_screen.dart';

class MyCustomNavBar extends StatelessWidget {
  final String screen;
  const MyCustomNavBar({Key key, this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: BottomAppBar(
        child: Container(
          color: Color(0xFF00BABA),
          height: height * 0.08,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            //padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  padding: EdgeInsets.zero,
                  onPressed: (screen != "Home")
                      ? () {
                          Navigator.pushNamed(context, Dashboard.id);
                        }
                      : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.home_filled,
                          color: (screen != "Home")
                              ? Colors.white
                              : Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          "Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.024,
                            color: (screen != "Home")
                                ? Colors.white
                                : Colors.greenAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, DepositsListScreen.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.account_balance_wallet_sharp,
                          color: (screen != "Deposits")
                              ? Colors.white
                              : Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          "Deposits",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.024,
                            color: (screen != "Deposits")
                                ? Colors.white
                                : Colors.greenAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, LoansListScreen.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.monetization_on_sharp,
                          color: (screen != "Loans")
                              ? Colors.white
                              : Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          "Loans",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.024,
                            color: (screen != "Loans")
                                ? Colors.white
                                : Colors.greenAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileScreen.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.account_box_sharp,
                          color: (screen != "Profile")
                              ? Colors.white
                              : Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          "Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.024,
                            color: (screen != "Profile")
                                ? Colors.white
                                : Colors.greenAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                )
                // NavbarButton(
                //   text: 'Profile',
                //   route: ProfileScreen.id,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final String text;
  final String route;
  final String svg;

  const NavbarButton({this.text, this.route, this.svg});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialButton(
      minWidth: 40,
      padding: EdgeInsets.zero,
      onPressed: route != ""
          ? () {
              Navigator.pushNamed(context, route);
            }
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: width * 0.15,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.024,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
