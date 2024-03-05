import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:onfly_app/src/data/datasources/local/converters/datetime_type_converter.dart';

void main() {
  group('DateTimeTypeConverter', () {
    final converter = DateTimeTypeConverter();
    final formatter = DateFormat('dd-MM-yyyy');

    test('should decode a formatted string to DateTime', () {
      const databaseValue = '01-01-2022';
      final expectedDateTime = formatter.parse(databaseValue);

      final decodedDateTime = converter.decode(databaseValue);

      expect(decodedDateTime, expectedDateTime);
    });

    test('should encode a DateTime to a formatted string', () {
      final dateTime = DateTime(2022, 1, 1);
      const expectedDatabaseValue = '01-01-2022';

      final encodedValue = converter.encode(dateTime);

      expect(encodedValue, expectedDatabaseValue);
    });
  });
}