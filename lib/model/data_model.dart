import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class Data extends HiveObject {
  @HiveField(0)
  DateTime? date;

  @HiveField(1)
  String? city;

  @HiveField(2)
  double? price;

  Data({this.city, this.date, this.price});
}
