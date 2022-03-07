import 'package:flutter/material.dart';
import 'package:somobay/models/deposit.dart';
import 'package:somobay/provider/user_provider.dart';
import 'package:somobay/view/deposit_details_screen.dart';

import 'components/customAppBar.dart';
import 'components/customBottomNavBar.dart';
import 'components/customDrawer.dart';
import 'components/loadingIndicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DepositsListScreen extends StatefulWidget {
  static const String id = 'deposits';
  const DepositsListScreen({Key key}) : super(key: key);

  @override
  _DepositsListScreenState createState() => _DepositsListScreenState();
}

class _DepositsListScreenState extends State<DepositsListScreen> {
  bool _inProcess = false;
  List<Deposit> deposits = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeposits();
  }

  getDeposits() async {
    await context.read(userProvider).getDeposits();
    setState(() {
      deposits = context.read(userProvider).deposits;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(
        title: "Deposits",
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
                    for (Deposit deposit in deposits)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DepositDetailsScreen(deposit: deposit)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF000000).withOpacity(0.1),
                                  offset: Offset.fromDirection(1),
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: space * 0.02),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Target Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Paid Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Deposit Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Status: "),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(deposit.targetAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(deposit.totalAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(deposit.depositAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${deposit.delayed ? "Delayed" : "Okay"}",
                                          style: TextStyle(
                                              color: deposit.delayed
                                                  ? Colors.deepOrange
                                                  : Colors.green),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            (_inProcess) ? LoadingIndicator() : Center()
          ],
        ),
      ),
      bottomNavigationBar: MyCustomNavBar(
        screen: 'Deposits',
      ),
    );
  }
}
