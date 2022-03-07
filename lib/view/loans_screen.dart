import 'package:flutter/material.dart';
import 'package:somobay/models/loan.dart';
import 'package:somobay/provider/user_provider.dart';
import 'package:somobay/view/loan_details_screen.dart';

import 'components/customAppBar.dart';
import 'components/customBottomNavBar.dart';
import 'components/customDrawer.dart';
import 'components/loadingIndicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoansListScreen extends StatefulWidget {
  static const String id = 'loans';
  const LoansListScreen({Key key}) : super(key: key);

  @override
  _LoansListScreenState createState() => _LoansListScreenState();
}

class _LoansListScreenState extends State<LoansListScreen> {
  bool _inProcess = false;
  List<Loan> loans = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoans();
  }

  getLoans() async {
    await context.read(userProvider).getLoans();
    setState(() {
      loans = context.read(userProvider).loans;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(
        title: "Loans",
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
                    for (Loan loan in loans)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoanDetailsScreen(loan: loan)));
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
                                        Text("Loan Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Paid Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Installment Amount: "),
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
                                        Text(loan.loanAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(loan.totalAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(loan.installmentAmount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${loan.delayed ? "Delayed" : "Okay"}",
                                          style: TextStyle(
                                              color: loan.delayed
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
        screen: 'Loans',
      ),
    );
  }
}
