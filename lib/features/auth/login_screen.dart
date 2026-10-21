import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';
import 'auth_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.primary.withValues(alpha: .07),
              Theme.of(context).scaffoldBackgroundColor,
              colors.secondary.withValues(alpha: .08),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: .24),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.volunteer_activism,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.groups_rounded,
                              size: 19,
                              color: colors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Comunidade em Ação',
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bem-vindo de volta',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sua presença faz a diferença real em vidas e comunidades vizinhas.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 28),
                    Card(
                      elevation: 1,
                      color: colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AuthTextField(
                                controller: _emailController,
                                label: 'E-mail',
                                hint: 'seu@email.com',
                                icon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  final email = value?.trim() ?? '';
                                  if (email.isEmpty ||
                                      !email.contains('@') ||
                                      !email.contains('.')) {
                                    return 'Informe um e-mail válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Senha',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () => _showMessage(
                                      'A recuperação de senha estará disponível em breve.',
                                    ),
                                    child: const Text('Esqueceu sua senha?'),
                                  ),
                                ],
                              ),
                              AuthTextField(
                                controller: _passwordController,
                                label: 'Senha',
                                hint: 'Sua senha secreta',
                                icon: Icons.lock_outline,
                                textInputAction: TextInputAction.done,
                                obscureText: _obscurePassword,
                                onToggleVisibility: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                validator: (value) => (value?.isEmpty ?? true)
                                    ? 'Informe sua senha'
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) => setState(
                                      () => _rememberMe = value ?? false,
                                    ),
                                  ),
                                  const Text('Lembrar de mim'),
                                  const Spacer(),
                                  Icon(
                                    Icons.circle,
                                    size: 9,
                                    color: colors.secondary,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '30 dias conectado',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              PrimaryButton(
                                label: 'Entrar na minha conta',
                                icon: Icons.arrow_forward,
                                onPressed: _login,
                              ),
                              const SizedBox(height: 14),
                              OutlinedButton.icon(
                                onPressed: () => _showMessage(
                                  'O acesso por biometria estará disponível em breve.',
                                ),
                                icon: Icon(
                                  Icons.fingerprint,
                                  color: colors.secondary,
                                ),
                                label: const Text(
                                  'Entrar com biometria ou Face ID',
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: colors.primary.withValues(
                                    alpha: .06,
                                  ),
                                  side: BorderSide.none,
                                  minimumSize: const Size.fromHeight(48),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: colors.outlineVariant,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Text(
                                      'OU CONTINUE COM',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: colors.outlineVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: _SocialButton(
                                      label: 'Google',
                                      icon: Icons.g_mobiledata,
                                      onPressed: () => _showMessage(
                                        'O acesso com Google estará disponível em breve.',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _SocialButton(
                                      label: 'Apple',
                                      icon: Icons.apple,
                                      onPressed: () => _showMessage(
                                        'O acesso com Apple estará disponível em breve.',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: .07),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundColor: colors.primary.withValues(
                              alpha: .18,
                            ),
                            child: Icon(
                              Icons.groups_rounded,
                              color: colors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: const [
                                  TextSpan(
                                    text: 'Mais de 4.800 vizinhos conectados\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '26 ações de voluntariado acontecem por aqui.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Ainda não faz parte dessa rede?',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text(
                        'Criar meu perfil',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 18,
                          color: colors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Conexão segura e dados protegidos',
                          style: Theme.of(context).textTheme.bodyMedium,
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
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
    style: OutlinedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary
          .withValues(alpha: .06),
      side: BorderSide.none,
      minimumSize: const Size.fromHeight(48),
    ),
  );
}
