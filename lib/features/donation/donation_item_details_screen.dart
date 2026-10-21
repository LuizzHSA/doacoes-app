import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class DonationItemDetailsScreen extends StatefulWidget {
  const DonationItemDetailsScreen({super.key, required this.itemId});

  final String itemId;

  @override
  State<DonationItemDetailsScreen> createState() =>
      _DonationItemDetailsScreenState();
}

class _DonationItemDetailsScreenState extends State<DonationItemDetailsScreen> {
  final _messageController = TextEditingController(
    text: 'Olá Marina! Esse carrinho será muito importante para nossa família.',
  );
  int _selectedPhoto = 0;
  int _purpose = 0;
  String _pickupDay = 'Amanhã (quinta)';
  String _pickupTime = '18h30 às 19h';

  static const _photos = [
    'https://images.unsplash.com/photo-1591348278863-a8fb3887e2aa?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=1200&q=85',
    'https://images.unsplash.com/photo-1519689680058-324335c77eba?auto=format&fit=crop&w=1200&q=85',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ReferenceHeader(title: 'Detalhes do Item'),
    body: ResponsivePageBody(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: ListView(
        children: [
          _gallery(),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ReferencePill(label: 'Gratuito', color: AppColors.secondaryContainer, foregroundColor: AppColors.secondary),
              ReferencePill(label: 'Bebês & Crianças'),
              ReferencePill(label: 'Seminovo / Conservado'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Carrinho de Bebê Reclinável + Moisés',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, height: 1.15),
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(Icons.schedule, color: AppColors.primary, size: 17),
              SizedBox(width: 6),
              Text('Publicado há 2 horas em São Paulo'),
            ],
          ),
          const SizedBox(height: 14),
          _donorCard(),
          const SizedBox(height: 14),
          _pickupCard(),
          const SizedBox(height: 14),
          _requestCard(),
          const SizedBox(height: 14),
          _safetyNotice(),
          const SizedBox(height: 92),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: FilledButton.icon(
        onPressed: _sendRequest,
        icon: const Icon(Icons.chat_outlined),
        label: const Text('Enviar solicitação e abrir chat seguro'),
      ),
    ),
  );

  Widget _gallery() => ReferenceCard(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: _photos.length,
            onPageChanged: (index) => setState(() => _selectedPhoto = index),
            itemBuilder: (context, index) => ReferencePhoto(
              imageUrl: _photos[index],
              height: 250,
              icon: Icons.child_friendly,
              borderRadius: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: List.generate(
              _photos.length + 1,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedPhoto = index.clamp(0, _photos.length - 1)),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: index == _selectedPhoto
                          ? const Color(0xFFD4E3FF)
                          : AppColors.lightSurfaceContainer,
                      border: Border.all(
                        color: index == _selectedPhoto ? AppColors.primary : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      index == _photos.length ? Icons.photo_library_outlined : Icons.image_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _donorCard() => ReferenceCard(
    child: Column(
      children: [
        const Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFD9E3F9),
              child: Icon(Icons.person, color: AppColors.primary, size: 30),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Marina Silveira  ✓', style: TextStyle(fontWeight: FontWeight.w800)),
                  Text('Pinheiros, SP • a 1,2 km de você', style: TextStyle(fontSize: 12)),
                  Text('★ 4,9  •  14 doações concluídas', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightSurfaceContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '“Usado por 6 meses pelo meu filho, higienizado e funcionando perfeitamente. Quero que ajude uma família que esteja precisando.”',
          ),
        ),
      ],
    ),
  );

  Widget _pickupCard() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading('Pontos e horários de retirada'),
        const SizedBox(height: 10),
        const _PickupInfo(
          icon: Icons.apartment,
          title: 'Ponto principal',
          description: 'Portaria com guarita 24h ou Ponto de Apoio Comunitário Morro da Cruz.',
        ),
        const SizedBox(height: 8),
        const _PickupInfo(
          icon: Icons.calendar_month_outlined,
          title: 'Disponibilidade',
          description: 'Segunda a sexta, das 18h às 21h; sábados pela manhã.',
        ),
        const SizedBox(height: 10),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFE3EDF3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: ReferencePill(
              label: 'Ponto seguro recomendado',
              color: Colors.white,
              icon: Icons.shield_outlined,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _requestCard() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          'Solicitar este item',
          trailing: ReferencePill(
            label: 'Etapa 1 de 2',
            color: AppColors.secondaryContainer,
            foregroundColor: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 12),
        const Text('Finalidade do pedido', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: 0, label: Text('Minha família'), icon: Icon(Icons.family_restroom)),
            ButtonSegment(value: 1, label: Text('Instituição'), icon: Icon(Icons.groups_outlined)),
          ],
          selected: {_purpose},
          onSelectionChanged: (value) => setState(() => _purpose = value.first),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(child: Text('Mensagem para Marina', style: TextStyle(fontWeight: FontWeight.w700))),
            Text('${_messageController.text.length}/250', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _messageController,
          maxLength: 250,
          maxLines: 4,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Conte brevemente por que este item será importante.',
            counterText: '',
          ),
        ),
        const SizedBox(height: 12),
        const Text('Previsão para retirada segura', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _pickupDay,
                items: const [
                  DropdownMenuItem(value: 'Amanhã (quinta)', child: Text('Amanhã (quinta)')),
                  DropdownMenuItem(value: 'Sexta-feira', child: Text('Sexta-feira')),
                  DropdownMenuItem(value: 'Sábado', child: Text('Sábado')),
                ],
                onChanged: (value) => setState(() => _pickupDay = value ?? _pickupDay),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _pickupTime,
                items: const [
                  DropdownMenuItem(value: '18h30 às 19h', child: Text('18h30 às 19h')),
                  DropdownMenuItem(value: '19h30 às 20h30', child: Text('19h30 às 20h30')),
                  DropdownMenuItem(value: '9h30 às 10h30', child: Text('9h30 às 10h30')),
                ],
                onChanged: (value) => setState(() => _pickupTime = value ?? _pickupTime),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _safetyNotice() => ReferenceCard(
    color: const Color(0xFFD8FAF7),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.verified_user_outlined, color: AppColors.secondary),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Os itens são gratuitos. Combine a retirada em local público e não compartilhe dados bancários ou senhas.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );

  void _sendRequest() {
    if (_messageController.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escreva uma mensagem um pouco mais detalhada.')),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.secondaryContainer,
                child: Icon(Icons.mark_email_read_outlined, color: AppColors.secondary),
              ),
              const SizedBox(height: 12),
              const Text('Solicitação enviada!', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('A doadora receberá sua mensagem. A conversa segura será habilitada após a integração.'),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Entendi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickupInfo extends StatelessWidget {
  const _PickupInfo({required this.icon, required this.title, required this.description});

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.lightSurfaceContainer,
      borderRadius: BorderRadius.circular(9),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              Text(description, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}