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
    DateTime joinedAt;
    try {
      joinedAt = DateTime.tryParse(json['joinedAt']) ?? DateTime.now();
    } catch (e) {
      joinedAt = DateTime.now();
    }
    double balanceInRs;
    try {
      balanceInRs = double.tryParse(json['balanceInRs']) ?? 0.0;
    } catch (e) {
      balanceInRs = (json['balanceInRs'] as num).toDouble();
      // int.tryParse(json['balanceInRs'])?.toDouble() ?? 0.0;
    }

    return VillagerModel(
      id: json['id'],
      name: json['name'],
      balanceInRs: balanceInRs,
      joinedAt: joinedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balanceInRs': balanceInRs,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}
