class Campaign {
  const Campaign({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.raised,
    required this.goal,
    required this.supporters,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json['id'] as String? ?? '',
    title: json['title'] as String? ?? '',
    category: json['category'] as String? ?? '',
    description: json['description'] as String? ?? '',
    raised: _toDouble(json['raised']),
    goal: _toDouble(json['goal']),
    supporters: _toDouble(json['supporters']).toInt(),
  );

  final String id;
  final String title;
  final String category;
  final String description;
  final double raised;
  final double goal;
  final int supporters;
  double get progress => goal <= 0 ? 0 : (raised / goal).clamp(0, 1);
}


double _toDouble(Object? value) =>
    value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
