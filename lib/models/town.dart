import 'package:hive/hive.dart';
part 'town.g.dart';

@HiveType(typeId: 0)
class Town extends HiveObject {
  @HiveField(0)
  late int woeid;
  @HiveField(1)
  late String title;
  Town(this.title, this.woeid);

  factory Town.fromJson(List<dynamic> json) {
    return Town(
      json[0]['title'],
      json[0]['woeid'],
    );
  }
}
