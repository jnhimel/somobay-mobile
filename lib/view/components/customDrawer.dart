import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:somobay/provider/user_provider.dart';

import '../login_screen.dart';

class MyCustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider user = context.read(userProvider);
    final double space = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Color(0xFF3C4858)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            user.loginStatus
                ? Column(
                    children: [
                      DrawerHeader(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: space * 0.35,
                                      child: Text(
                                        '${user.currentUser().firstName.toString()}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : DrawerHeader(
                    child: Container(),
                  ),
            // MenuHeader(text: 'Notification'),
            // MenuOption(text: 'Notification', switchValue: false),
            // MenuOption(text: 'App Notification', switchValue: true),
            MenuItem(text: 'Language'),
            MenuItem(text: 'Support'),
            user.loginStatus
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Card(
                        color: Color(0xFF3C4858),
                        child: FlatButton(
                          onPressed: () async {
                            bool logout = await user.logout();
                            if (!logout) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Color(0xFF6A6F77),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF969CA7), fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF969CA7),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  MenuOption({this.text, this.switchValue});

  final String text;

  final bool switchValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF969CA7), fontSize: 16),
            ),
          ),
          Transform.scale(
            scale: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  border: Border.all(
                    width: 0,
                  )),
              child: CupertinoSwitch(
                value: switchValue,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  MenuHeader({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Divider(color: Colors.white),
        ),
      ],
    );
  }
}
