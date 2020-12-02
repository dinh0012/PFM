import 'package:personal_financial_management/models/select_item.dart';

class DateHelper {
  static allDaySelection() {
    List<SelectItem> allDay = new List();
    for (var i = 1; i <= 31; i++) {
      allDay.add(new SelectItem(label: i.toString(), value: i.toString()));
    }
    return allDay;
  }
}
