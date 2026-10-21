class DonationItem {
  const DonationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory DonationItem.fromJson(Map<String, dynamic> json) => DonationItem(
    id: json['id'] as String? ?? '',
    title: json['titulo'] as String? ?? '',
    description: json['descricao'] as String? ?? '',
    status: json['status'] as String? ?? 'disponivel',
  );

  final String id;
  final String title;
  final String description;
  final String status;
}