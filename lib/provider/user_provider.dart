import 'dart:convert';
import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somobay/models/auth.dart';
import 'package:somobay/models/index.dart';
import 'package:somobay/models/user.dart';

class UserProvider extends ChangeNotifier {
  String url = "192.168.0.100:8080";
  SharedPreferences loginData;
  User _user;
  Auth _auth;
  String number;
  String token;
  bool loginStatus = false;
  bool newNotification = false;
  String authToken;

  List<Deposit> deposits;
  List<Loan> loans;

  User currentUser() {
    return _user;
  }

  Future getDeposits() async {
    var queryParameters = {
      'userId': '${_user.userId}',
    };
    var uri = Uri.http('$url', '/deposit/user', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      List<dynamic> depositResponse = jsonDecode(response.body);
      deposits = (depositResponse)
          ?.map((e) =>
              e == null ? null : Deposit.fromJson(e as Map<String, dynamic>))
          ?.toList();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<List<Transaction>> getTransactions(Deposit deposit) async {
    List<Transaction> transactions = [];
    var queryParameters = {
      'depositId': '${deposit.id}',
    };
    var uri = Uri.http(
        '$url', '/deposit/transaction/getByDepositId', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      List<dynamic> depositResponse = jsonDecode(response.body);
      transactions = (depositResponse)
          ?.map((e) => e == null
              ? null
              : Transaction.fromJson(e as Map<String, dynamic>))
          ?.toList();
      notifyListeners();
      return transactions;
    } else {
      return transactions;
    }
  }

  Future<List<Installment>> getInstallments(Loan loan) async {
    List<Installment> installments = [];
    var queryParameters = {
      'loanId': '${loan.id}',
    };
    var uri =
        Uri.http('$url', '/loan/installment/getByLoanId', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      List<dynamic> installmentsResponse = jsonDecode(response.body);
      installments = (installmentsResponse)
          ?.map((e) => e == null
              ? null
              : Installment.fromJson(e as Map<String, dynamic>))
          ?.toList();
      notifyListeners();
      return installments;
    } else {
      return installments;
    }
  }

  Future makeTransaction(String depositId, Transaction transaction) async {
    var queryParameters = {
      'depositId': depositId,
    };
    var uri = Uri.http('$url', '/deposit/transaction/add', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(transaction.toJson()),
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      return loginStatus;
    } else {
      return false;
    }
  }

  Future makeInstallment(String loanId, Installment installment) async {
    var queryParameters = {
      'loanId': loanId,
    };
    var uri = Uri.http('$url', '/loan/installment/add', queryParameters);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(installment.toJson()),
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      return loginStatus;
    } else {
      return false;
    }
  }

  Future getLoans() async {
    var queryParameters = {
      'userId': '${_user.userId}',
    };
    var uri = Uri.http('$url', '/loan/getByUser', queryParameters);
    var response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: authToken,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      List<dynamic> loanResponse = jsonDecode(response.body);
      loans = (loanResponse)
          ?.map((e) =>
              e == null ? null : Loan.fromJson(e as Map<String, dynamic>))
          ?.toList();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future _getUser() async {
    var queryParameters = {
      'phoneNumber': '$number',
    };
    var uri = Uri.http('$url', '/getUserByPhoneNumber', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      _user = User.fromJson(userMap);
    }
    notifyListeners();
  }

  Future login(String number, String password) async {
    bool timedOut = false;
    var queryParameters = {
      'phoneNumber': '$number',
    };
    var uri = Uri.http('$url', '/login', queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          "Basic " + base64.encode(utf8.encode(number + ":" + password)),
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    print(response.body);
    if (response.body != null && response.statusCode == 200) {
      Map loginMap = jsonDecode(response.body);
      _auth = Auth.fromJson(loginMap);
      if (_auth.authorities[0].authority == "user") {
        this.number = number;
        this.authToken =
            "Basic " + base64.encode(utf8.encode(number + ":" + password));
        await _getUser().timeout(Duration(seconds: 60), onTimeout: () {
          timedOut = true;
          return null;
        });
        if (timedOut) {
          await logout();
          this.loginStatus = false;
        } else {
          this.loginStatus = true;
          loginData = await SharedPreferences.getInstance();
          loginData.setBool("login", false);
          loginData.setString("number", number);
          loginData.setString("authToken", authToken);
        }
        notifyListeners();
      } else {
        print("Not User");
        return loginStatus;
      }
    }
    return loginStatus;
  }

  Future logout() async {
    var uri = Uri.http(
      '$url',
      '/logoutUser',
    );
    var response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: authToken,
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    // print(response.body);
    if (response.body != null && response.statusCode == 200) {
      this.loginStatus = false;
      this._user = null;
      this.number = null;
      // this.password = null;
      this.authToken = null;
      notifyListeners();
      loginData = await SharedPreferences.getInstance();
      loginData.clear();
      return loginStatus;
    }
    return loginStatus;
  }
}

final userProvider = Provider((_) => UserProvider());
