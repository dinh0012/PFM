import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_financial_management/models/select_item.dart';
import 'package:personal_financial_management/widgets/field.dart';
import 'package:personal_financial_management/widgets/field_type.dart';
import 'package:personal_financial_management/widgets/form_custom.dart';
import 'firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'taskscreen.dart';
import 'task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items = new List();

    todoTasks?.cancel();
    todoTasks = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Task> tasks = snapshot.documents
          .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            padding: EdgeInsets.all(16.0),
            child: FormCustom(
              initialValues: {'a': '12345', 'a2': '2'},
              children: (values, initialValues) => [
                Field(
                    type: FieldType.inputMoney,
                    labelText: 'cố định',
                    name: 'a',
                    initialValue: initialValues['a'],
                    onSaved: (userName) {
                      values['a'] = userName;
                    }),
                Field(
                    type: FieldType.selection,
                    labelText: 'cố định 2',
                    initialValue: initialValues['a2'],
                    name: 'a2',
                    items: [
                      new SelectItem(label: 'Label 1', value: '1'),
                      new SelectItem(label: 'Label 2', value: '2'),
                      new SelectItem(label: 'Label 3', value: '3'),
                      new SelectItem(label: 'Label 4', value: '4'),
                      new SelectItem(label: 'Label 5', value: '5'),
                    ],
                    onSaved: (value) {
                      values['a2'] = value;
                    }),
                Field(
                    type: FieldType.input,
                    labelText: 'cố định 3',
                    name: 'a3'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFA7397),
        child: Icon(
          FontAwesomeIcons.listUl,
          color: Color(0xFFFDDE42),
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskScreen(Task('', '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }

  Widget todoType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'travel':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color(0xff4158ba);
        break;
      case 'shopping':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color(0xfffb537f);
        break;
      case 'gym':
        iconval = FontAwesomeIcons.dumbbell;
        colorval = Color(0xff4caf50);
        break;
      case 'party':
        iconval = FontAwesomeIcons.glassCheers;
        colorval = Color(0xff9962d0);
        break;
      default:
        iconval = FontAwesomeIcons.tasks;
        colorval = Color(0xff0dc8f5);
      //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }

  Widget _myAppBar(context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFFA7397),
              const Color(0xFFFDDE42),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'ToDo Tasks',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
