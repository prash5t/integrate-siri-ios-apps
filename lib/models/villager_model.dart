class VillagerModel {
  final String id;
  final String name;
  final double balanceInRs;

  VillagerModel({
    required this.id,
    required this.name,
    required this.balanceInRs,
  });

  factory VillagerModel.fromJson(Map<String, dynamic> json) {
    return VillagerModel(
      id: json['id'],
      name: json['name'],
      balanceInRs: json['balanceinRs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balanceInRs': balanceInRs,
    };
  }
}
