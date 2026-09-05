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
  final String id;
  final String title;
  final String category;
  final String description;
  final double raised;
  final double goal;
  final int supporters;
  double get progress => (raised / goal).clamp(0, 1);
}

const campaigns = [
  Campaign(
    id: 'kits-escolares',
    title: 'Kits Escolares para o Jardim Esperança',
    category: 'Educação',
    description: 'Vamos equipar 50 crianças com o material necessário para um início de ano letivo digno e cheio de potencial.',
    raised: 3500,
    goal: 5000,
    supporters: 242,
  ),
  Campaign(
    id: 'cozinha-solidaria',
    title: 'Cozinha Solidária Paraisópolis',
    category: 'Alimentos',
    description: 'Garantindo 500 refeições diárias para famílias em situação de vulnerabilidade.',
    raised: 15000,
    goal: 20000,
    supporters: 320,
  ),
  Campaign(
    id: 'agasalho',
    title: 'Campanha do Agasalho',
    category: 'Saúde',
    description:
        'Aquecendo famílias durante o inverno com roupas e cobertores.',
    raised: 2800,
    goal: 5000,
    supporters: 118,
  ),
];
