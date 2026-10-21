import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _filter = 'Todas';

  static const _entries = [
    _HistoryEntry(
      type: 'Em dinheiro',
      badge: 'PIX • R\$ 100,00',
      date: 'Ontem às 14:32',
      title: 'Cestas Básicas Emergenciais',
      community: 'Comunidade Morro da Cruz',
      status: 'Entregue às famílias',
      detail: 'Distribuído pela liderança Dona Marta',
      icon: Icons.shopping_bag_outlined,
      done: true,
    ),
    _HistoryEntry(
      type: 'Itens físicos',
      badge: 'Item físico',
      date: '12 de maio de 2024',
      title: 'Carrinho de bebê Burigotto',
      community: 'Retirada presencial concluída',
      status: 'Retirado com sucesso',
      detail: 'Entregue à beneficiária Júlia M.',
      icon: Icons.child_friendly,
      done: true,
    ),
    _HistoryEntry(
      type: 'Em dinheiro',
      badge: 'Cartão • R\$ 50,00',
      date: '28 de abril de 2024',
      title: 'Material Escolar Volta às Aulas',
      community: 'Vila Esperança • 120 crianças',
      status: 'Meta atingida • compras em cotação',
      detail: 'Aquisição em lote com desconto comunitário.',
      icon: Icons.school_outlined,
      done: false,
    ),
    _HistoryEntry(
      type: 'Itens físicos',
      badge: '3 volumes',
      date: '15 de abril de 2024',
      title: 'Agasalhos e cobertores de inverno',
      community: 'Ponto de Coleta Morro da Cruz',
      status: 'Distribuído na ação de inverno',
      detail: 'Acolhimento de 48 pessoas em situação de rua.',
      icon: Icons.checkroom_outlined,
      done: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visibleEntries = _entries.where((entry) {
      return _filter == 'Todas' || entry.type == _filter;
    }).toList();

    return Scaffold(
      appBar: const ReferenceHeader(title: 'Perfil'),
      body: ResponsivePageBody(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _profileSummary(),
            const SizedBox(height: 18),
            const SectionHeading(
              'Histórico e rastreio',
              trailing: ReferencePill(
                label: 'Tempo real',
                color: Colors.transparent,
                foregroundColor: AppColors.secondary,
                icon: Icons.circle,
              ),
            ),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 'Todas', label: Text('Todas')),
                ButtonSegment(value: 'Em dinheiro', label: Text('Em dinheiro')),
                ButtonSegment(value: 'Itens físicos', label: Text('Itens físicos')),
              ],
              selected: {_filter},
              onSelectionChanged: (value) => setState(() => _filter = value.first),
            ),
            const SizedBox(height: 12),
            ...visibleEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _HistoryCard(entry: entry, onAction: _showAction),
              ),
            ),
            const SizedBox(height: 6),
            const SectionHeading('Conta e transparência'),
            const SizedBox(height: 8),
            ReferenceCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _accountAction(Icons.notifications_none, 'Notificações e avisos', 'WhatsApp e push instantâneo'),
                  const Divider(height: 1),
                  _accountAction(Icons.account_balance_wallet_outlined, 'Chaves Pix e cartões', 'Métodos de pagamento salvos'),
                  const Divider(height: 1),
                  _accountAction(Icons.description_outlined, 'Declaração de IR solidário', 'Exportar informe consolidado'),
                  const Divider(height: 1),
                  _accountAction(Icons.policy_outlined, 'Termos e auditoria aberta', 'Regras comunitárias e prestação de contas'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Sair da conta', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileSummary() => ReferenceCard(
    child: Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: Color(0xFFD4E3FF),
              child: Icon(Icons.person, size: 38, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Camila Silveira', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  Text('Pinheiros, São Paulo - SP'),
                  Text('Membro ativa desde março de 2023', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Editar perfil',
              onPressed: () => _showAction('Editar perfil'),
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Column(
          children: [
            Row(
              children: [
                Expanded(child: _ProfileMetric(icon: Icons.payments_outlined, label: 'TOTAL DOADO', value: 'R\$ 650', detail: '100% auditado')),
                Expanded(child: _ProfileMetric(icon: Icons.campaign_outlined, label: 'CAMPANHAS', value: '8', detail: 'comunidades locais')),
              ],
            ),
            Row(
              children: [
                Expanded(child: _ProfileMetric(icon: Icons.inventory_2_outlined, label: 'ITENS FÍSICOS', value: '5 itens', detail: 'entregues em mãos')),
                Expanded(child: _ProfileMetric(icon: Icons.groups_outlined, label: 'IMPACTO DIRETO', value: '24 vidas', detail: 'alcançadas')),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _accountAction(IconData icon, String title, String subtitle) => ListTile(
    leading: Icon(icon, color: AppColors.primary),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => _showAction(title),
  );

  void _showAction(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title será conectado depois.')),
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(3),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.lightSurfaceContainer,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800))),
          ],
        ),
        const SizedBox(height: 3),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
        ),
        Text(detail, style: const TextStyle(fontSize: 10)),
      ],
    ),
  );
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry, required this.onAction});

  final _HistoryEntry entry;
  final ValueChanged<String> onAction;

  @override
  Widget build(BuildContext context) => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    children: [
                      ReferencePill(
                        label: entry.badge,
                        color: entry.type == 'Itens físicos'
                            ? const Color(0xFFFFDDB4)
                            : const Color(0xFFD4E3FF),
                      ),
                      Text(entry.date, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                  Text(entry.community, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.lightSurfaceContainer,
              child: Icon(entry.icon, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: entry.done ? const Color(0xFFD8FAF7) : const Color(0xFFFFF1D6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(entry.done ? Icons.check_circle_outline : Icons.pending_outlined, color: entry.done ? AppColors.secondary : AppColors.accent),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.status, style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(entry.detail, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            _TimelineNode(label: 'Recebido', done: true),
            Expanded(child: Divider(color: AppColors.secondary)),
            _TimelineNode(label: 'Organizado', done: true),
            Expanded(child: Divider(color: AppColors.secondary)),
            _TimelineNode(label: 'Famílias', done: false),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          children: [
            ActionChip(
              avatar: const Icon(Icons.download_outlined, size: 16),
              label: const Text('Recibo'),
              onPressed: () => onAction('Recibo'),
            ),
            ActionChip(
              avatar: const Icon(Icons.verified_outlined, size: 16),
              label: const Text('Comprovante'),
              onPressed: () => onAction('Comprovante'),
            ),
          ],
        ),
      ],
    ),
  );
}

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CircleAvatar(
        radius: 10,
        backgroundColor: done ? AppColors.secondary : AppColors.surfaceContainerHigh,
        child: Icon(done ? Icons.check : Icons.more_horiz, size: 12, color: done ? Colors.white : AppColors.primary),
      ),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(fontSize: 9)),
    ],
  );
}

class _HistoryEntry {
  const _HistoryEntry({
    required this.type,
    required this.badge,
    required this.date,
    required this.title,
    required this.community,
    required this.status,
    required this.detail,
    required this.icon,
    required this.done,
  });

  final String type;
  final String badge;
  final String date;
  final String title;
  final String community;
  final String status;
  final String detail;
  final IconData icon;
  final bool done;
}