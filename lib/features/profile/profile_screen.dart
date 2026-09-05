import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/state/app_providers.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_shell.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: PageHeader(title: 'Minhas Doações', onProfile: () {}),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 56, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(
                  'João Silva',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text('joao.silva@exemplo.com'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              _Stat(value: '12', label: 'Doações'),
              SizedBox(width: 12),
              _Stat(value: '8', label: 'Campanhas'),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Minhas Doações',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const _Donation(
            title: 'Cestas Básicas - Vila Nova',
            detail: 'R\$ 50,00 • Há 2 dias',
            status: 'Em andamento',
            color: AppColors.accent,
            icon: Icons.shopping_bag_outlined,
          ),
          const SizedBox(height: 10),
          const _Donation(
            title: 'Material Escolar - Creche',
            detail: 'Kit Completo • Há 2 semanas',
            status: 'Entregue',
            color: AppColors.secondary,
            icon: Icons.inventory_2_outlined,
          ),
          const SizedBox(height: 28),
          const Text('CONFIGURAÇÕES', style: TextStyle(letterSpacing: 1.2)),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Tema Escuro'),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  value: dark,
                  onChanged: (value) =>
                      ref.read(themeModeProvider.notifier).toggle(value),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.notifications_none),
                  title: Text('Notificações'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text('Privacidade e Segurança'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppOutlinedButton(
            label: 'Sair da conta',
            icon: Icons.logout,
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Card(
      color: AppColors.primary.withValues(alpha: .12),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(label),
          ],
        ),
      ),
    ),
  );
}

class _Donation extends StatelessWidget {
  const _Donation({
    required this.title,
    required this.detail,
    required this.status,
    required this.color,
    required this.icon,
  });
  final String title;
  final String detail;
  final String status;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: .15),
        child: Icon(icon, color: color),
      ),
      title: Text(title, overflow: TextOverflow.ellipsis),
      subtitle: Text('$status • $detail'),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}
