/// Auxiliary model to storage a mission's mane with its id number.
class MissionItem {
  final String name;
  final int id;

  const MissionItem(this.name, this.id);

  factory MissionItem.fromJson(Map<String, dynamic> json) {
    return MissionItem(json['name'], json['flight']);
  }
}
