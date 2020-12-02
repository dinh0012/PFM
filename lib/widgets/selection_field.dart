import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/models/select_item.dart';

class SelectionField extends StatefulWidget {
  final InputDecoration decoration;
  final Function onSaved;
  final initialValue;
  final List<SelectItem> items;

  SelectionField(
      {this.decoration, this.onSaved, this.initialValue, this.items});

  @override
  _SelectionFieldState createState() =>
      _SelectionFieldState(initialValue, onSaved);
}

class _SelectionFieldState extends State<SelectionField> {
  var _currentSelectedValue;

  _SelectionFieldState(initialValue, onSaved) {
    this._currentSelectedValue = initialValue;
    onSaved(initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: widget.decoration,
            isEmpty:
                _currentSelectedValue == null || _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: '4',
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedValue = newValue;
                    state.didChange(newValue);
                    widget.onSaved(newValue);
                  });
                },
                items: widget.items.map((SelectItem item) {
                  return DropdownMenuItem<String>(
                    value: item.value,
                    child: Text(
                      item.label,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
