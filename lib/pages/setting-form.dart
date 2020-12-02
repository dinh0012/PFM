import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_financial_management/helpers/date_helper.dart';
import 'package:personal_financial_management/models/setting.dart';
import 'package:personal_financial_management/services/firestoreservice.dart';
import 'package:personal_financial_management/widgets/field.dart';
import 'package:personal_financial_management/widgets/field_type.dart';
import 'package:personal_financial_management/widgets/form_custom.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  Setting setting = new Setting();
  Map settingData = {};
  bool _progressController = true;

  @override
  void initState() {
    super.initState();
    setting.getBaseSettingData().listen((DocumentSnapshot snapshot) {
      setState(() {
        this.settingData = snapshot.data;
        _progressController = false;
      });
    });
  }

  _savedSetting(values) {
    setting.updateBaseSettingData(values);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _progressController
          ? CircularProgressIndicator()
          : FormCustom(
        initialValues: settingData,
        onSaved: _savedSetting,
        children: (values, initialValues) =>
        [
          Field(
              type: FieldType.inputMoney,
              labelText: 'Lương cố định',
              name: 'salary',
              initialValue: initialValues['salary'],
              onSaved: (salary) {
                values['salary'] = salary;
              }),
          Field(
              type: FieldType.selection,
              labelText: 'Chu kỳ lương hàng tháng',
              initialValue: initialValues['periodSalary'],
              name: 'periodSalary',
              items: DateHelper.allDaySelection(),
              onSaved: (value) {
                values['periodSalary'] = value;
              }),
        ],
      ),
    );
  }
}


