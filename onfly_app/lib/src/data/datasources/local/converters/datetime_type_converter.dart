import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

class DateTimeTypeConverter extends TypeConverter<DateTime, String> {
  @override
  DateTime decode(String databaseValue) {
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.parse(databaseValue);
  }

  @override
  String encode(DateTime value) {
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(value); 
  }
}