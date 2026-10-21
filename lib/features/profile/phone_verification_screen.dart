import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/reference_ui.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  Timer? _countdownTimer;
  int _secondsRemaining = 45;
  String _channel = 'WhatsApp';
  bool _neighborhoodUpdates = true;
  bool _goalNotifications = true;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ReferenceHeader(title: 'Cadastro básico'),
    body: ResponsivePageBody(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PASSO 2 DE 2', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
              Text('Verificação e segurança', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 1),
          const SizedBox(height: 16),
          _phoneCard(),
          const SizedBox(height: 14),
          _otpCard(),
          const SizedBox(height: 14),
          _trustCard(),
          const SizedBox(height: 14),
          _preferencesCard(),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _verify,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Validar e ativar conta'),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => _showMessage('Entre em contato com o suporte da comunidade.'),
            icon: const Icon(Icons.support_agent),
            label: const Text('Problemas com a verificação? Falar com suporte'),
          ),
        ],
      ),
    ),
  );

  Widget _phoneCard() => ReferenceCard(
    child: Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.secondaryContainer,
          child: Icon(Icons.mark_chat_unread_outlined, color: AppColors.secondary, size: 30),
        ),
        const SizedBox(height: 10),
        const Text('Confirme seu número', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text(
          'Enviamos um código de verificação de 6 dígitos para o seu aparelho:',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone_iphone, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('+55 (11) 98765-4321', style: TextStyle(fontWeight: FontWeight.w800)),
            IconButton(
              tooltip: 'Alterar número',
              onPressed: () => _showMessage('Edição do telefone será conectada ao cadastro.'),
              icon: const Icon(Icons.edit_outlined, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: 'WhatsApp', label: Text('WhatsApp'), icon: Icon(Icons.chat_outlined)),
            ButtonSegment(value: 'SMS', label: Text('SMS tradicional'), icon: Icon(Icons.sms_outlined)),
          ],
          selected: {_channel},
          onSelectionChanged: (value) => setState(() => _channel = value.first),
        ),
      ],
    ),
  );

  Widget _otpCard() => ReferenceCard(
    child: Column(
      children: [
        const Text('Digite o código recebido', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            _controllers.length,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == 5 ? 0 : 5),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => _onDigitChanged(index, value),
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: '•',
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('Reenviar código em 00:${_secondsRemaining.toString().padLeft(2, '0')}'),
        TextButton(
          onPressed: _secondsRemaining == 0 ? _resendCode : null,
          child: Text('Não recebeu? Reenviar por $_channel'),
        ),
      ],
    ),
  );

  Widget _trustCard() => ReferenceCard(
    color: const Color(0xFFD8FAF7),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.verified_user_outlined, color: Colors.white),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Por que validamos seu número?', style: TextStyle(fontWeight: FontWeight.w800)),
              SizedBox(height: 4),
              Text('A verificação ajuda a proteger doações e cria uma rede confiável de voluntários e comunidades.'),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _preferencesCard() => ReferenceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PREFERÊNCIAS DA COMUNIDADE', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
        const SizedBox(height: 6),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Receber atualizações de campanhas da vizinhança'),
          value: _neighborhoodUpdates,
          onChanged: (value) => setState(() => _neighborhoodUpdates = value),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Avisar quando uma meta apoiada for alcançada'),
          value: _goalNotifications,
          onChanged: (value) => setState(() => _goalNotifications = value),
        ),
      ],
    ),
  );

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() => _secondsRemaining = 45);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _resendCode() {
    _startCountdown();
    _showMessage('Código demonstrativo reenviado por $_channel.');
  }

  void _verify() {
    final code = _controllers.map((controller) => controller.text).join();
    if (code.length != _controllers.length) {
      _showMessage('Digite os seis dígitos do código.');
      return;
    }
    _showMessage('Verificação visual concluída. O serviço ainda não está integrado.');
    context.go('/home');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}