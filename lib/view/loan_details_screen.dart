import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:somobay/models/index.dart';
import 'package:somobay/models/loan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:somobay/payment/aamarpayData.dart';
import 'package:somobay/provider/user_provider.dart';
import 'package:somobay/view/profile_screen.dart';

import 'components/customAppBar.dart';
import 'components/customBottomNavBar.dart';
import 'components/customDrawer.dart';
import 'components/loadingIndicator.dart';
import 'components/space.dart';

class LoanDetailsScreen extends StatefulWidget {
  final Loan loan;
  const LoanDetailsScreen({Key key, this.loan}) : super(key: key);

  @override
  _LoanDetailsScreenState createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  bool _inProcess = false;
  List<Installment> installments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInstallments();
  }

  getInstallments() async {
    installments =
        await context.read(userProvider).getInstallments(widget.loan);
    setState(() {});
  }

  makeInstallment() async {
    setState(() {
      _inProcess = true;
    });
    Installment installment = new Installment();
    installment.amount = widget.loan.installmentAmount;
    bool payment = await context
        .read(userProvider)
        .makeInstallment(widget.loan.id.toString(), installment);
    if (payment) {
      getInstallments();
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
      makeInstallment();
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
        title: "Loan Details",
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
                            title: "Payable Amount",
                            text: widget.loan.targetAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Loan Amount",
                            text: widget.loan.loanAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Total Paid Amount",
                            text: widget.loan.totalAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Installment Amount",
                            text: widget.loan.installmentAmount.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Interval",
                            text: widget.loan.period.toString() + " Days",
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Start Date",
                            text: widget.loan.startDate.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "End Date",
                            text: widget.loan.endDate.toString(),
                            // icon: Icons.account_circle,
                            space: space,
                          ),
                          Space(space: space),
                          DetailsWidget(
                            title: "Status",
                            text: widget.loan.active
                                ? widget.loan.complete
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
                      "Installments",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                      ),
                    ),
                    widget.loan.active
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
                                      widget.loan.installmentAmount,
                                  transactionID:
                                      "deposit:${widget.loan.id}:${DateTime.now().toIso8601String()}",
                                  description:
                                      "deposit transaction of ${widget.loan.id}",
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
                                        "Make Installment",
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
                    for (Installment transaction in installments.reversed)
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
                                        Text("Installment Amount: "),
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
