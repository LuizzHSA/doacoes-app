import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class DonationCheckoutScreen extends StatefulWidget {
  const DonationCheckoutScreen({super.key, required this.campaignId});

  final String campaignId;

  @override
  State<DonationCheckoutScreen> createState() => _DonationCheckoutScreenState();
}

class _DonationCheckoutScreenState extends State<DonationCheckoutScreen> {
  final _amountController = TextEditingController(text: '100');
  final _cpfController = TextEditingController();
  double _amount = 100;
  bool _monthly = false;
  bool _anonymous = false;
  String _paymentMethod = 'PIX';

  static const _amounts = [
    (20.0, 'Garante 2 dias de leite'),
    (50.0, 'Meia cesta básica'),
    (100.0, 'Cesta básica familiar'),
    (200.0, 'Apoia duas famílias'),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ReferenceHeader(title: 'Checkout de Doação'),
    body: ResponsivePageBody(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _campaignSummary(),
          const SizedBox(height: 18),
          const Text('Frequência da contribuição', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: false, label: Text('Doação única'), icon: Icon(Icons.favorite_border)),
              ButtonSegment(value: true, label: Text('Mensal'), icon: Icon(Icons.autorenew)),
            ],
            selected: {_monthly},
            onSelectionChanged: (value) => setState(() => _monthly = value.first),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(child: Text('Escolha ou digite um valor', style: TextStyle(fontWeight: FontWeight.w800))),
              Text('100% para a causa', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.secondary)),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _amounts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final (amount, description) = _amounts[index];
              final selected = _amount == amount;
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _selectAmount(amount),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFD4E3FF) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? AppColors.primary : Colors.transparent,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Color(0x0A17233B), blurRadius: 10, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${amount.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Expanded(child: Text(description, style: const TextStyle(fontSize: 12))),
                      if (amount == 100)
                        const ReferencePill(
                          label: 'Mais escolhido',
                          color: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ReferenceCard(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const ReferencePill(label: 'R\$', color: Color(0xFFD4E3FF), foregroundColor: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: _onCustomAmountChanged,
                    decoration: const InputDecoration(
                      labelText: 'Outro valor solidário',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ReferenceCard(
            color: const Color(0xFFD8FAF7),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.secondary),
                const SizedBox(width: 8),
                Expanded(child: Text(_impactText)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Método de pagamento', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: 'PIX', label: Text('PIX'), icon: Icon(Icons.qr_code_2)),
              ButtonSegment(value: 'Cartão', label: Text('Cartão'), icon: Icon(Icons.credit_card)),
              ButtonSegment(value: 'Carteiras', label: Text('Carteiras'), icon: Icon(Icons.account_balance_wallet_outlined)),
            ],
            selected: {_paymentMethod},
            onSelectionChanged: (value) => setState(() => _paymentMethod = value.first),
          ),
          const SizedBox(height: 10),
          _paymentPanel(),
          const SizedBox(height: 12),
          _receiptOptions(),
          const SizedBox(height: 12),
          ReferenceCard(
            color: AppColors.lightSurfaceContainer,
            child: Row(
              children: [
                const Icon(Icons.verified_outlined, color: AppColors.secondary),
                const SizedBox(width: 10),
                const Expanded(child: Text('Taxa da plataforma: R\$ 0,00\n100% da contribuição vai para a causa.')),
                const ReferencePill(label: 'Zero taxa', color: AppColors.secondaryContainer, foregroundColor: AppColors.secondary),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _confirmPayment,
            icon: const Icon(Icons.arrow_forward),
            label: Text('Continuar com R\$ ${_amount.toStringAsFixed(2)}'),
          ),
          const SizedBox(height: 8),
          const Center(child: Text('Pagamento seguro • Esta tela é apenas uma demonstração.', style: TextStyle(fontSize: 11))),
          const SizedBox(height: 18),
        ],
      ),
    ),
  );

  String get _impactText {
    if (_amount >= 200) return 'Sua contribuição pode apoiar duas famílias.';
    if (_amount >= 100) return 'Sua contribuição pode ajudar com uma cesta familiar.';
    if (_amount >= 50) return 'Sua contribuição ajuda a completar uma cesta básica.';
    return 'Cada contribuição ajuda a atender uma necessidade local.';
  }

  Widget _campaignSummary() => ReferenceCard(
    child: Column(
      children: [
        const Row(
          children: [
            SizedBox(
              width: 58,
              height: 58,
              child: ReferencePhoto(
                height: 58,
                icon: Icons.volunteer_activism,
                borderRadius: 8,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CAUSA VERIFICADA', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w800, fontSize: 11)),
                  Text('Cestas Básicas Emergenciais', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                  Text('Associação Morro da Cruz'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.lightSurfaceContainer, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Meta comunitária do mês'), Text('90% alcançada', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800))],
              ),
              const SizedBox(height: 6),
              const LinearProgressIndicator(value: .9),
              const SizedBox(height: 6),
              Text('Campanha ${widget.campaignId} • faltam R\$ 2.450 para atender 120 famílias.', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _paymentPanel() {
    if (_paymentMethod == 'PIX') {
      return ReferenceCard(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReferencePill(label: 'Aprovação instantânea', color: AppColors.secondaryContainer, foregroundColor: AppColors.secondary, icon: Icons.circle),
                Text('Válido por 14:58', style: TextStyle(fontSize: 11)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.lightSurfaceContainer),
              ),
              child: const Icon(Icons.qr_code_2, size: 116, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text('QR Code demonstrativo. O pagamento ainda não está conectado.', textAlign: TextAlign.center),
            const SizedBox(height: 10),
            const TextField(
              readOnly: true,
              controller: null,
              decoration: InputDecoration(
                labelText: 'Código Pix copia e cola',
                hintText: 'Código será gerado pelo provedor de pagamento',
                suffixIcon: Icon(Icons.copy),
              ),
            ),
          ],
        ),
      );
    }
    return ReferenceCard(
      child: Column(
        children: [
          Icon(
            _paymentMethod == 'Cartão' ? Icons.credit_card : Icons.account_balance_wallet_outlined,
            size: 38,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          Text('Pagamento por $_paymentMethod será habilitado com o provedor escolhido.', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _receiptOptions() => ReferenceCard(
    child: Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _anonymous,
          onChanged: (value) => setState(() => _anonymous = value),
          secondary: const Icon(Icons.visibility_off_outlined),
          title: const Text('Doação anônima'),
          subtitle: const Text('Oculta seu nome na lista de apoiadores.'),
        ),
        const Divider(),
        TextField(
          controller: _cpfController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'CPF para recibo (opcional)',
            hintText: '000.000.000-00',
            prefixIcon: Icon(Icons.receipt_long_outlined),
          ),
        ),
      ],
    ),
  );

  void _selectAmount(double amount) {
    setState(() {
      _amount = amount;
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  void _onCustomAmountChanged(String value) {
    final normalized = value.replaceAll(',', '.');
    setState(() => _amount = double.tryParse(normalized) ?? 0);
  }

  void _confirmPayment() {
    if (_amount < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O valor mínimo é R\$ 5,00.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout visual: nenhum pagamento foi processado.')),
    );
  }
}