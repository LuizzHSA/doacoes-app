import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';

class DonationConfirmationScreen extends StatelessWidget {
  const DonationConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmação')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: .18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.volunteer_activism,
                color: AppColors.primary,
                size: 100,
              ),
            ),
          ),
          const SizedBox(height: 34),
          Text(
            'Obrigado por sua doação, João!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          const Text(
            'Sua contribuição de R\$ 50,00 para a campanha "Kits Escolares" foi processada com sucesso.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          const _ImpactCard(),
          const SizedBox(height: 20),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  _TransactionRow(label: 'Data', value: '24 Out 2023, 14:32'),
                  _TransactionRow(label: 'Método', value: 'Pix'),
                  _TransactionRow(label: 'ID', value: '#TRX-987654321'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Ver Minhas Doações',
            icon: Icons.arrow_forward,
            onPressed: () => context.go('/profile'),
          ),
          const SizedBox(height: 12),
          AppOutlinedButton(
            label: 'Voltar para o Início',
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  const _ImpactCard();
  @override
  Widget build(BuildContext context) => Card(
    color: AppColors.secondary.withValues(alpha: .12),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: AppColors.secondary, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    ),
    child: const Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '♥ Seu Impacto',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Com a sua ajuda, estamos mais próximos de garantir o futuro de 50 crianças no Jardim Esperança.',
          ),
        ],
      ),
    ),
  );
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
