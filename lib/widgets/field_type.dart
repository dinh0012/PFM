class FieldType {
  static const FieldType input = FieldType('Input');
  static const FieldType datePicker = FieldType('DatePicker');
  static const FieldType selection = FieldType('Selection');
  final String type;
  const FieldType(String type) : type = type;
}
