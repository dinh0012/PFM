import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/widgets/field.dart';
class FormCustom extends StatefulWidget {
  final Function children ;
  final Map initialValues;

  FormCustom({this.children, this.initialValues });

  @override
  _FormFieldState createState() => _FormFieldState();
}

class _FormFieldState extends State<FormCustom> {
  final GlobalKey _formKey = GlobalKey();
  final Map values = new Map();
  @override
  Widget build(BuildContext context) {
    print(values);
    var initialValues = widget.initialValues;
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              ...widget.children(values, initialValues),
              FlatButton(
                onPressed: _submitForm,
                child: Icon(
                  Icons.access_alarm,
                ),
              )
            ]),
      ),
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    print(values);
    if (form.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      print(values);
    }
  }
}
