class VillagerModel {
  final String id;
  final String name;
  final double balanceInRs;
  final DateTime joinedAt;
  VillagerModel({
    required this.id,
    required this.name,
    required this.balanceInRs,
    required this.joinedAt,
  });

  factory VillagerModel.fromJson(Map<String, dynamic> json) {
    return VillagerModel(
      id: json['id'],
      name: json['name'],
      balanceInRs: json['balanceInRs'],
      joinedAt: DateTime.tryParse(json['joinedAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balanceInRs': balanceInRs,
      'joinedAt': joinedAt.toString(),
    };
  }
}
