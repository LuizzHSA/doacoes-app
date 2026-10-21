import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class ItemDonationFormScreen extends StatefulWidget {
  const ItemDonationFormScreen({super.key});

  @override
  State<ItemDonationFormScreen> createState() => _ItemDonationFormScreenState();
}

class _ItemDonationFormScreenState extends State<ItemDonationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pickupController = TextEditingController();
  final _scheduleController = TextEditingController();
  String _category = 'Bebês & Crianças';
  String _condition = 'Seminovo / Pouco uso';
  String _pickupType = 'Meu endereço ou bairro';
  bool _ethicalConfirmation = true;

  static const _categories = [
    'Roupas & Calçados',
    'Bebês & Crianças',
    'Móveis & Casa',
    'Alimentos & Cestas',
    'Educação & Livros',
    'Eletrônicos',
  ];

  static const _conditions = [
    'Novo / Na caixa',
    'Seminovo / Pouco uso',
    'Em bom estado',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pickupController.dispose();
    _scheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ReferenceHeader(title: 'Cadastro de Doação de Item'),
    body: ResponsivePageBody(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const ReferencePill(
              label: 'Comunidade em Ação',
              color: AppColors.secondaryContainer,
              foregroundColor: AppColors.secondary,
              icon: Icons.volunteer_activism,
            ),
            const SizedBox(height: 12),
            const Text(
              'Desapegue com propósito!',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text('O que você gostaria de compartilhar e transformar em acolhimento hoje?'),
            const SizedBox(height: 18),
            _photoSection(),
            const SizedBox(height: 14),
            _detailsSection(),
            const SizedBox(height: 14),
            _logisticsSection(),
            const SizedBox(height: 14),
            _destinationSection(),
            const SizedBox(height: 14),
            CheckboxListTile(
              value: _ethicalConfirmation,
              onChanged: (value) => setState(() => _ethicalConfirmation = value ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              tileColor: AppColors.lightSurfaceContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: const Text(
                'Confirmo que o item está limpo, higienizado e em condições dignas de uso.',
                style: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(height: 82),
          ],
        ),
      ),
    ),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.fromLTRB(18, 8, 18, 12),
      child: FilledButton.icon(
        onPressed: _publishDonation,
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Publicar doação de item'),
      ),
    ),
  );

  Widget _photoSection() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Fotos do item', trailing: Text('0 de 4 fotos')),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: ReferencePhoto(height: 96, icon: Icons.photo_camera_outlined),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 96)),
                onPressed: () => _showMessage('Seleção de fotos será integrada depois.'),
                icon: const Icon(Icons.add_a_photo_outlined),
                label: const Text('Adicionar foto'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Dica: fotos nítidas e iluminadas ajudam a identificar o item ideal.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );

  Widget _detailsSection() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Título do item *'),
        TextFormField(
          controller: _titleController,
          maxLength: 120,
          decoration: const InputDecoration(hintText: 'Ex.: Carrinho de bebê em ótimo estado'),
          validator: (value) => (value?.trim().length ?? 0) < 3 ? 'Informe um título.' : null,
        ),
        const SizedBox(height: 8),
        _sectionLabel('Categoria *'),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: _categories
              .map(
                (category) => ChoiceChip(
                  label: Text(category),
                  selected: _category == category,
                  onSelected: (_) => setState(() => _category = category),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        _sectionLabel('Estado de conservação *'),
        LayoutBuilder(
          builder: (context, constraints) => Wrap(
            spacing: 6,
            children: _conditions
                .map(
                  (condition) => SizedBox(
                    width: (constraints.maxWidth - 12) / 3,
                    child: ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Text(condition, textAlign: TextAlign.center, maxLines: 2),
                      ),
                      selected: _condition == condition,
                      onSelected: (_) => setState(() => _condition = condition),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        _sectionLabel('Descrição detalhada e dimensões'),
        TextFormField(
          controller: _descriptionController,
          maxLength: 500,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Informe medidas, acessórios e detalhes importantes...'),
        ),
      ],
    ),
  );

  Widget _logisticsSection() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Logística e retirada'),
        RadioListTile<String>(
          value: 'Meu endereço ou bairro',
          groupValue: _pickupType,
          onChanged: (value) => setState(() => _pickupType = value!),
          title: const Text('Retirada no meu endereço ou bairro'),
          contentPadding: EdgeInsets.zero,
        ),
        if (_pickupType == 'Meu endereço ou bairro')
          TextFormField(
            controller: _pickupController,
            decoration: const InputDecoration(hintText: 'Bairro ou ponto de referência'),
            validator: (value) => _pickupType == 'Meu endereço ou bairro' &&
                    (value?.trim().isEmpty ?? true)
                ? 'Informe um local de retirada.'
                : null,
          ),
        RadioListTile<String>(
          value: 'Ponto comunitário',
          groupValue: _pickupType,
          onChanged: (value) => setState(() => _pickupType = value!),
          title: const Text('Posso levar até um ponto comunitário'),
          contentPadding: EdgeInsets.zero,
        ),
        TextFormField(
          controller: _scheduleController,
          decoration: const InputDecoration(
            labelText: 'Dias e horários preferenciais',
            hintText: 'Ex.: sábados das 9h às 14h',
            prefixIcon: Icon(Icons.calendar_month_outlined),
          ),
        ),
      ],
    ),
  );

  Widget _destinationSection() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Comunidade destino'),
        const SizedBox(height: 4),
        const Text('Opcional: escolha uma comunidade que você já apoia.'),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: 'Aberto',
          decoration: const InputDecoration(),
          items: const [
            DropdownMenuItem(value: 'Aberto', child: Text('Aberto para quem solicitar primeiro')),
            DropdownMenuItem(value: 'Morro da Cruz', child: Text('Associação Morro da Cruz')),
            DropdownMenuItem(value: 'Esperança Viva', child: Text('Coletivo Esperança Viva')),
          ],
          onChanged: (_) {},
        ),
      ],
    ),
  );

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
  );

  void _publishDonation() {
    if (!_formKey.currentState!.validate()) return;
    if (!_ethicalConfirmation) {
      _showMessage('Confirme as condições de uso do item para continuar.');
      return;
    }
    _showMessage('Formulário validado. A publicação será conectada ao backend depois.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}