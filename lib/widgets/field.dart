
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/widgets/date_picker.dart';
import 'package:personal_financial_management/widgets/field_selection.dart';
import 'package:personal_financial_management/widgets/field_type.dart';

class Field extends StatelessWidget {
  final FieldType type;
  final String hintText;
  final String name;
  final String labelText;
  final initialValue;
  final value;
  final Function onSaved;
  final Function onChanged;

  Field({
    this.type,
    this.hintText = 'Nhập giá trị',
    this.labelText = 'Label',
    this.name,
    this.initialValue,
    this.value,
    this.onSaved,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: factoryField(),
    );
  }

  Widget factoryField() {
    switch (this.type) {
      case FieldType.selection:
        return FieldSelection(

        );
      case FieldType.input:
      default:
        return TextFormField(
            onSaved: this.onSaved,
            initialValue: this.initialValue,
            decoration: InputDecoration(
              hintText: this.hintText,
              labelText: this.labelText,
            ));
    }
  }
}
