import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
          child: Column(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.volunteer_activism,
                  color: AppColors.primary,
                  size: 52,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Faça parte da mudança',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Junte-se à nossa comunidade de empatia e ação.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'seu@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Esqueceu sua senha?'),
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                label: 'Entrar',
                icon: Icons.arrow_forward,
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: 26),
              const Text.rich(
                TextSpan(
                  text: 'Ainda não faz parte? ',
                  children: [
                    TextSpan(
                      text: 'Cadastre-se',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
