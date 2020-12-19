import 'package:flutter_test/flutter_test.dart';
import 'package:year_picker/year_picker.dart';

void main() {
  test('receive year on input', () {
    final yearPicker = YearPicker(
      firstDate: DateTime(2010),
      lastDate: DateTime(2020),
      onChanged: (d) {},
      selectedDate: DateTime(2020),
    );
    expect(yearPicker.firstDate, DateTime(2010));
    expect(yearPicker.lastDate, DateTime(2020));
  });
}
