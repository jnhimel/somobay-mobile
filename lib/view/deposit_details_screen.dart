import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:somobay/models/deposit.dart';
import 'package:somobay/models/index.dart';
import 'package:somobay/models/transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:somobay/payment/aamarpayData.dart';
import 'package:somobay/provider/user_provider.dart';
import 'package:somobay/view/profile_screen.dart';

import 'components/customAppBar.dart';
import 'components/customBottomNavBar.dart';
import 'components/customDrawer.dart';
import 'components/loadingIndicator.dart';
import 'components/space.dart';

class DepositDetailsScreen extends StatefulWidget {
  final Deposit deposit;
  const DepositDetailsScreen({Key key, this.deposit}) : super(key: key);

  @override
  _DepositDetailsScreenState createState() => _DepositDetailsScreenState();
}

class _DepositDetailsScreenState extends State<DepositDetailsScreen> {
  bool _inProcess = false;
  List<Transaction> transactions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
  }

  getTransactions() async {
    transactions =
        await context.read(userProvider).getTransactions(widget.deposit);
    setState(() {});
  }

  makeTransaction() async {
    setState(() {
      _inProcess = true;
    });
    Transaction transaction = new Transaction();
    transaction.amount = widget.deposit.depositAmount;
    bool payment = await context
        .read(userProvider)
        .makeTransaction(widget.deposit.id.toString(), transaction);
    if (payment) {
      getTransactions();
      Fluttertoast.showToast(
          msg: "Transaction is successfully done.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _inProcess = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Transaction failed.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _inProcess = false;
      });
    }
  }

  handlePayment(String paymentStatus) async {
    // await pr.hide();
    if (paymentStatus == "success") {
      Fluttertoast.showToast(
          msg: "Payment is successfully done.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      makeTransaction();
    } else if (paymentStatus == "fail") {
      Fluttertoast.showToast(
          msg: "Payment failed.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (paymentStatus == "cancel") {
      Fluttertoast.showToast(
          msg: "You have  canceled payment.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double space = MediaQuery.of(context).size.width;
    User user = context.read(userProvider).currentUser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyCustomAppBar(
        title: "Deposit Details",
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
                    Container(
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Space(space: space),
                          DetailsWidget(
                            title: "Deposit Amount",
                            text: widget.deposit.depositAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Total Paid Amount",
                            text: widget.deposit.totalAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Target Amount",
                            text: widget.deposit.targetAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Interval",
                            text: widget.deposit.period.toString() + " Days",
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Start Date",
                            text: widget.deposit.startDate.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "End Date",
                            text: widget.deposit.endDate.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Status",
                            text: widget.deposit.active
                                ? widget.deposit.complete
                                    ? "Complete"
                                    : "Active"
                                : "Deactivated",
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                        ],
                      ),
                    ),
                    Space(space: space),
                    Text(
                      "Transactions",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                    widget.deposit.active
                        ? Column(
                            children: [
                              Space(space: space),
                              AamarpayData(
                                  returnUrl: (url) {
                                    print(url);
                                  },
                                  isLoading: (v) async {
                                    setState(() {
                                      _inProcess = v;
                                    });
                                    // if (_inProcess) {
                                    //   pr.update(message: "Loading Payment");
                                    //   await pr.show();
                                    // } else {
                                    //   await pr.hide();
                                    // }
                                  },
                                  paymentStatus: (paymentStatus) async {
                                    print(paymentStatus);
                                    // await bookAppointment(paymentStatus);
                                    handlePayment(paymentStatus);
                                  },
                                  cancelUrl: "dacicil.com/payment/cancel",
                                  successUrl: "dacicil.com/payment/confirm",
                                  failUrl: "dacicil.com/payment/fail",
                                  customerEmail: user.email,
                                  customerMobile: user.phoneNumber,
                                  customerName:
                                      user.firstName + " " + user.lastName,
                                  signature: "dbb74894e82415a2f7ff0ec3a97e4183",
                                  storeID: "aamarpaytest",
                                  transactionAmount:
                                      widget.deposit.depositAmount,
                                  transactionID:
                                      "deposit:${widget.deposit.id}:${DateTime.now().toIso8601String()}",
                                  description:
                                      "deposit transaction of ${widget.deposit.id}",
                                  url: "https://sandbox.aamarpay.com",
                                  child: Container(
                                    height: space * .12,
                                    width: space * 0.60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00BABA),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Make Transaction",
                                        style: TextStyle(
                                            fontSize: space * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        : Container(),
                    Space(space: space),
                    for (Transaction transaction in transactions.reversed)
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             DepositDetailsScreen(deposit: deposit)));
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
                                        Text("Transaction Amount: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Date: "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Status: "),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(transaction.amount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(transaction.date.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${transaction.approved ? "Approved" : "Pending"}",
                                          style: TextStyle(
                                              color: transaction.approved
                                                  ? Colors.green
                                                  : Colors.deepOrange),
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
      bottomNavigationBar: MyCustomNavBar(),
    );
  }
}
