import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/validators/form_validators.dart';
import '../bloc/recovery_bloc.dart';
import '../bloc/recovery_event.dart';
import '../bloc/recovery_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/loading_widget.dart';

class RecoverySecretPage extends StatefulWidget {
  const RecoverySecretPage({super.key});

  @override
  State<RecoverySecretPage> createState() => _RecoverySecretPageState();
}

class _RecoverySecretPageState extends State<RecoverySecretPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _digitControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isCodeComplete = false;

  @override
  void initState() {
    super.initState();
    for (var focusNode in _focusNodes) {
      focusNode.addListener(() {
        setState(() {});
      });
    }

    for (var controller in _digitControllers) {
      controller.addListener(_checkCodeCompletion);
    }
  }

  @override
  void dispose() {
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleRecovery() {
    if (_formKey.currentState?.validate() ?? false) {
      final code =
          _digitControllers.map((controller) => controller.text).join();

      context.read<RecoveryBloc>().add(RecoverSecretRequested(
            username: 'admin', // Username padrão do teste
            password: 'password123', // Password padrão do teste
            recoveryCode: code,
          ));
    }
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _checkCodeCompletion() {
    final isComplete = _digitControllers.every((controller) =>
        controller.text.isNotEmpty && controller.text.length == 1);

    if (_isCodeComplete != isComplete) {
      setState(() {
        _isCodeComplete = isComplete;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.71, top: 6.41),
          child: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppConstants.loginRoute);
              }
            },
            icon: const SizedBox(
              width: 6.585,
              height: 11.175,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary, // #7A5D3E
                size: 20,
              ),
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              minimumSize: const Size(6.585, 11.175),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ),
      body: BlocListener<RecoveryBloc, RecoveryState>(
        listener: (context, state) {
          if (state is RecoverySuccess) {
            // Show success message
            CustomSnackBar.showSuccess(
              context,
              'Código confirmado com sucesso!',
            );
            // Navigate back to login
            context.go(AppConstants.loginRoute);
          } else if (state is RecoveryError) {
            CustomSnackBar.showError(
              context,
              state.message,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: BlocBuilder<RecoveryBloc, RecoveryState>(
              builder: (context, state) {
                if (state is RecoveryLoading) {
                  return const LoadingWidget(message: 'Verificando código...');
                }

                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Verificação',
                            style: AppTypography.verificationTitle,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Insira o código que foi enviado:',
                            style: AppTypography.verificationInstruction,
                          ),
                        ),
                        const SizedBox(height: 62),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (index) => Flexible(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 60,
                                  minWidth: 45,
                                ),
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: TextFormField(
                                  controller: _digitControllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.inputTextColor,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: AppColors.inputFillColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorderColor,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: AppColors.inputBorderColor,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color:
                                            AppColors.inputFocusedBorderColor,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  onChanged: (value) =>
                                      _onDigitChanged(value, index),
                                  validator: FormValidators.validateDigit,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Recovery Button
                        CustomButton(
                          text: 'Confirmar',
                          onPressed: _isCodeComplete ? _handleRecovery : null,
                          isLoading: state is RecoveryLoading,
                          textStyle: AppTypography.loginButton,
                          backgroundColor: _isCodeComplete
                              ? AppColors.primary
                              : AppColors.primaryDisabled,
                        ),
                        const SizedBox(height: 16),
                        // Code not received button
                        TextButton.icon(
                          onPressed: null,
                          icon: const Iconify(
                            Mdi.message_question_outline,
                            size: 16,
                            color: AppColors.labelText,
                          ),
                          label: Text(
                            'Não recebi o código',
                            style: AppTypography.codeNotReceivedButton,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
