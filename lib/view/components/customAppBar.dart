import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDashboard;
  final String title;
  const MyCustomAppBar({
    Key key,
    this.title = "Somobay",
    this.isDashboard = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: space * 0.02),
        color: Color(0xFFF7F7F7),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDashboard
                      ? TextButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFEDF0F0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.menu,
                              color: Color(0xFF00CACA),
                            ),
                          ))
                      : TextButton(
                          onPressed: !isDashboard
                              ? () {
                                  Navigator.pop(context);
                                }
                              : null,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFEDF0F0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF00CACA),
                            ),
                          )),
                  Container(
                    width: space * 0.6,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight:
                              isDashboard ? FontWeight.bold : FontWeight.normal,
                          fontSize: isDashboard ? 24 : 20,
                          color: isDashboard ? Color(0xFF00CACA) : kTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
