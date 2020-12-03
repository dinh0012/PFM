import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Container(
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: items
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        shadowColor: Color(0x802196F3),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${item.title}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10.0),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${item.description}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${item.percent}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10.0),
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
                ),
              )
              .toList()),
    );
  }
}
