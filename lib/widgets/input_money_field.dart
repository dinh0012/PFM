import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputMoneyField extends StatelessWidget {
  final Function onSaved;
  final InputDecoration decoration;
  final initialValue;
  final _controller = TextEditingController();
  InputMoneyField({this.onSaved, this.initialValue, this.decoration}) {
    this._controller.value = TextEditingValue(
      text: '${_formatNumber(this.initialValue != null ? this.initialValue : '0'.replaceAll(',', ''))}',
      selection: TextSelection.collapsed(offset: initialValue?.length),
    );
    this.onSaved(initialValue);
  }

  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: _controller,
        decoration: decoration,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final string = '${_formatNumber(value.replaceAll(',', ''))}';
          _controller.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
          onSaved(value.replaceAll(',', ''));
        },
      ),
    );
  }
}
