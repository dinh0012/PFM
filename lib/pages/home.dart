import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/helpers/color_account.dart';
import 'package:personal_financial_management/models/account.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Account account = new Account();
  List<Account> items;

  @override
  void initState() {
    super.initState();
    items = new List();

    account.getAccountInfo().listen((QuerySnapshot snapshot) {
      final List<Account> accounts = snapshot.documents
          .map((documentSnapshot) => account.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = accounts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colorsAccount = ColorAccount.colors;
    return Container(
        child: ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) => Container(
        height: (MediaQuery.of(context).size.height - 160) / items.length,
        child: Padding(
          padding: EdgeInsets.only(top: 0, bottom: 5),
          child: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${items[index].title}',
                      style: TextStyle(
                          color: colorsAccount[index], fontSize: 10.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${items[index].description}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${items[index].percent}%',
                          style: TextStyle(
                              color: colorsAccount[index],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
