import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/validators/form_validators.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(LoginRequested(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppConstants.homeRoute);
          } else if (state is AuthSecretRequired) {
            context.go(AppConstants.recoveryRoute);
          } else if (state is AuthError) {
            CustomSnackBar.showError(
              context,
              state.message,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: LoadingWidget(message: 'Entrando...'),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: constraints.maxHeight < 500
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Spacer(),
                                // Illustration section
                                SizedBox(
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                        Positioned(
                                          top: 90,
                                          left: 0,
                                          child: Image.asset(
                                            'assets/images/illustrations/Vector13.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 0,
                                          child: Image.asset(
                                            'assets/images/illustrations/Vector14.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Center(
                                          child: Image.asset(
                                            'assets/images/illustrations/image2.png',
                                            height: 180,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Email Field
                                CustomTextField(
                                  controller: _usernameController,
                                  labelText: 'Email',
                                  hintText: 'Digite seu email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: FormValidators.validateEmail,
                                ),
                                const SizedBox(height: 16),

                                // Password Field
                                CustomTextField(
                                  controller: _passwordController,
                                  labelText: 'Senha',
                                  hintText: 'Digite sua senha',
                                  obscureText: true,
                                  validator: FormValidators.validatePassword,
                                ),
                                const SizedBox(height: 24),

                                // Login Button
                                CustomButton(
                                  text: 'Entrar',
                                  onPressed: _handleLogin,
                                  isLoading: state is AuthLoading,
                                  textStyle: AppTypography.loginButton,
                                ),
                                const Spacer(),
                                // Forgot Password Button
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Esqueci a senha',
                                    style: AppTypography.forgotPasswordButton,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
