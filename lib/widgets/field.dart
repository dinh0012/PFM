import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/models/select_item.dart';
import 'package:personal_financial_management/widgets/input_money_field.dart';
import 'package:personal_financial_management/widgets/selection_field.dart';
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
  final List<SelectItem> items;

  Field({
    this.type,
    this.hintText = 'Nhập giá trị',
    this.labelText = 'Label',
    this.name,
    this.initialValue,
    this.value,
    this.onSaved,
    this.items,
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
        return SelectionField(
          decoration: InputDecoration(
            hintText: this.hintText,
            labelText: this.labelText,
          ),
          onSaved: this.onSaved,
          initialValue: this.initialValue,
          items: this.items,
        );
      case FieldType.inputMoney:
        return InputMoneyField(
            onSaved: this.onSaved,
            initialValue: this.initialValue,
            decoration: InputDecoration(
              hintText: this.hintText,
              labelText: this.labelText,
            ));
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
