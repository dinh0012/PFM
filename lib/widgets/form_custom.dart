import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/widgets/field.dart';
class FormCustom extends StatefulWidget {
  final Function children ;
  final Future Function(Map<String, dynamic>)  onSaved ;
  final Map initialValues;
  final SnackBar snackBar;

  FormCustom({this.children, this.initialValues, this.onSaved, this.snackBar });

  @override
  _FormFieldState createState() => _FormFieldState();
}

class _FormFieldState extends State<FormCustom> {
  final GlobalKey _formKey = GlobalKey();
  final Map<String, dynamic> values = new Map();
  @override
  Widget build(BuildContext context) {
    var initialValues = widget.initialValues;
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              ...widget.children(values, initialValues),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: _submitForm,

                  //    Icons.access_alarm,
                ),
            ]),
      ),
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      widget.onSaved(values).then((value) => {
        if (widget.snackBar == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Đã lưu thành công'),
            duration: const Duration(seconds: 1),
          ))
        }
      });
    }
  }
}
