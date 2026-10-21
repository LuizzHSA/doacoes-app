import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';
import 'auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final Set<String> _selectedCauses = {};
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;
  bool _acceptedTerms = false;
  String _participation = 'Ambos';

  static const _causes = [
    'Alimentação',
    'Educação',
    'Saúde',
    'Infância',
    'Animais',
    'Idosos',
  ];

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      (value?.trim().isEmpty ?? true) ? 'Este campo é obrigatório' : null;

  void _completeRegistration() {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Aceite os termos para concluir seu cadastro.'),
          ),
        );
      return;
    }
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strength = _passwordStrength(_passwordController.text);
    final strengthLabel = switch (strength) {
      0 => 'Digite uma senha',
      1 => 'Fraca',
      2 => 'Média',
      _ => 'Forte',
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Icons.arrow_back),
                    tooltip: 'Voltar para o login',
                  ),
                  Expanded(
                    child: Text(
                      'Cadastro Básico',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: colors.primary,
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Passo 1 de 2',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Seus Dados e Causas',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              value: .5,
                              minHeight: 6,
                              backgroundColor: colors.primary.withValues(
                                alpha: .14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: .08),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: colors.secondary.withValues(
                                    alpha: .22,
                                  ),
                                  child: Icon(
                                    Icons.volunteer_activism,
                                    color: colors.secondary,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bem-vindo(a) à rede!',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Conectamos corações dispostos a mudar realidades locais.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      radius: 48,
                                      backgroundColor: colors.primary
                                          .withValues(alpha: .14),
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                        color: colors.primary,
                                      ),
                                    ),
                                    Positioned(
                                      right: -3,
                                      bottom: -2,
                                      child: IconButton.filled(
                                        onPressed: () =>
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'O envio de foto estará disponível em breve.',
                                                  ),
                                                ),
                                              ),
                                        tooltip: 'Adicionar foto',
                                        icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Adicione sua foto',
                                  style: TextStyle(color: colors.primary),
                                ),
                                Text(
                                  'Isso humaniza sua atuação e gera confiança',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _SectionTitle(
                            icon: Icons.badge_outlined,
                            title: 'Informações Pessoais',
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            label: 'Nome completo',
                            hint: 'Como podemos chamar você?',
                            icon: Icons.person_outline,
                            validator: _required,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            label: 'E-mail',
                            hint: 'seu@email.com',
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              if (email.isEmpty ||
                                  !email.contains('@') ||
                                  !email.contains('.')) {
                                return 'Informe um e-mail válido';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            label: 'Telefone / WhatsApp',
                            hint: '(11) 98765-4321',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: _required,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            label: 'Sua Cidade / Bairro',
                            hint: 'Ex.: Pinheiros, São Paulo - SP',
                            icon: Icons.location_on_outlined,
                            validator: _required,
                            textInputAction: TextInputAction.next,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 5),
                            child: Text(
                              'Conectamos você a ações próximas da sua região',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _SectionTitle(
                            icon: Icons.favorite_border,
                            title: 'Causas no Coração',
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Selecione as áreas que você mais deseja apoiar:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 2,
                            children: _causes.map((cause) {
                              final selected = _selectedCauses.contains(cause);
                              return FilterChip(
                                label: Text(cause),
                                selected: selected,
                                avatar: Icon(
                                  _causeIcon(cause),
                                  size: 17,
                                  color: selected
                                      ? Colors.white
                                      : colors.primary,
                                ),
                                onSelected: (value) => setState(() {
                                  if (value) {
                                    _selectedCauses.add(cause);
                                  } else {
                                    _selectedCauses.remove(cause);
                                  }
                                }),
                                selectedColor: colors.primary,
                                labelStyle: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : colors.onSurface,
                                ),
                                showCheckmark: false,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 22),
                          _SectionTitle(
                            icon: Icons.handshake_outlined,
                            title: 'Como você quer atuar?',
                          ),
                          const SizedBox(height: 10),
                          SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(
                                value: 'Doar',
                                label: Text('Quero doar'),
                              ),
                              ButtonSegment(
                                value: 'Voluntário',
                                label: Text('Ser voluntário'),
                              ),
                              ButtonSegment(
                                value: 'Ambos',
                                label: Text('Ambos'),
                              ),
                            ],
                            selected: {_participation},
                            showSelectedIcon: false,
                            onSelectionChanged: (selection) => setState(
                              () => _participation = selection.first,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _SectionTitle(
                            icon: Icons.lock_outline,
                            title: 'Segurança da Conta',
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            controller: _passwordController,
                            label: 'Crie uma senha de acesso',
                            hint: 'Mínimo de 8 caracteres',
                            icon: Icons.key_outlined,
                            obscureText: _obscurePassword,
                            onToggleVisibility: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            onChanged: (_) => setState(() {}),
                            validator: (value) {
                              if ((value?.length ?? 0) < 8) {
                                return 'Use pelo menos 8 caracteres';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: .07),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Força da senha: $strengthLabel',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                    Icon(
                                      Icons.verified_user_outlined,
                                      size: 16,
                                      color: strength == 3
                                          ? colors.secondary
                                          : colors.onSurfaceVariant,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: List.generate(
                                    3,
                                    (index) => Expanded(
                                      child: Container(
                                        height: 4,
                                        margin: EdgeInsets.only(
                                          right: index == 2 ? 0 : 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: strength > index
                                              ? colors.secondary
                                              : colors.outlineVariant,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          AuthTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirmar senha',
                            hint: 'Digite sua senha novamente',
                            icon: Icons.check_circle_outline,
                            obscureText: _obscureConfirmation,
                            onToggleVisibility: () => setState(
                              () =>
                                  _obscureConfirmation = !_obscureConfirmation,
                            ),
                            validator: (value) =>
                                value != _passwordController.text
                                ? 'As senhas não coincidem'
                                : null,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: .07),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CheckboxListTile(
                              value: _acceptedTerms,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) => setState(
                                () => _acceptedTerms = value ?? false,
                              ),
                              title: const Text.rich(
                                TextSpan(
                                  text: 'Li e concordo com os ',
                                  children: [
                                    TextSpan(
                                      text: 'Termos de Uso',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(text: ' e a '),
                                    TextSpan(
                                      text: 'Política de Privacidade',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' e Transparência de doações.',
                                    ),
                                  ],
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          PrimaryButton(
                            label: 'Concluir Cadastro e Começar',
                            icon: Icons.arrow_forward,
                            onPressed: _completeRegistration,
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text('Já tem uma conta? '),
                              TextButton(
                                onPressed: () => context.go('/login'),
                                child: const Text(
                                  'Fazer Login',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _passwordStrength(String password) {
    if (password.isEmpty) return 0;
    if (password.length < 8) return 1;
    if (password.length >= 12 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return 3;
    }
    return 2;
  }

  IconData _causeIcon(String cause) => switch (cause) {
    'Alimentação' => Icons.restaurant,
    'Educação' => Icons.school_outlined,
    'Saúde' => Icons.medical_services_outlined,
    'Infância' => Icons.child_care_outlined,
    'Animais' => Icons.pets_outlined,
    _ => Icons.elderly_outlined,
  };
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: Theme.of(context).colorScheme.primary, size: 21),
      const SizedBox(width: 8),
      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
    ],
  );
}
