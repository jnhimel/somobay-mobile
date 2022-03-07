import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:somobay/view/deposits_screen.dart';
import 'package:somobay/view/loans_screen.dart';

import '../constants.dart';
import 'components/customAppBar.dart';
import 'components/customBottomNavBar.dart';
import 'components/customDrawer.dart';
import 'components/loadingIndicator.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _inProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ExitModalBottomSheet(space: space);
            });
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyCustomAppBar(
          isDashboard: true,
        ),
        drawer: MyCustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: space * 0.01, horizontal: space * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Row 1
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: space * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, DepositsListScreen.id),
                              child: DashboardTile(
                                space: space,
                                title: "Deposits",
                                value: "৳",
                                primaryColor: Colors.green,
                                secondaryColor: Colors.blue,
                                icon: Icons.account_balance_wallet_rounded,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, LoansListScreen.id),
                              child: DashboardTile(
                                space: space,
                                title: "Loans",
                                value: "৳",
                                primaryColor: Colors.orange,
                                secondaryColor: Colors.green,
                                icon: Icons.monetization_on_sharp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (_inProcess) ? LoadingIndicator() : Center()
            ],
          ),
        ),
        bottomNavigationBar: MyCustomNavBar(
          screen: 'Home',
        ),
      ),
    );
  }
}

class ExitModalBottomSheet extends StatelessWidget {
  const ExitModalBottomSheet({
    Key key,
    @required this.space,
  }) : super(key: key);

  final double space;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Color(0xFF00BABA),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Do you want to exit?",
              style: kButtonTextStyle.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Container(
                      width: space * 0.15,
                      height: space * 0.1,
                      decoration: kButtonDecoration,
                      alignment: Alignment.center,
                      child: Text(
                        "No",
                        style:
                            kButtonTextStyle.copyWith(color: Color(0xFF00BABA)),
                      ),
                    )),
                TextButton(
                    onPressed: () => exit(0),
                    child: Container(
                      width: space * 0.15,
                      height: space * 0.1,
                      decoration: kButtonDecoration,
                      alignment: Alignment.center,
                      child: Text(
                        "Yes",
                        style:
                            kButtonTextStyle.copyWith(color: Color(0xFF00BABA)),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final String value;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;
  const DashboardTile({
    Key key,
    @required this.space,
    @required this.title,
    @required this.value,
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.icon,
  }) : super(key: key);

  final double space;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: space * 0.42,
      height: space * 0.35,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: space * 0.1,
                  height: space * 0.1,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: space * 0.08,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: space * 0.245,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: space * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'See details',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
