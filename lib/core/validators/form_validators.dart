// lib/core/validators/form_validators.dart
class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validateDigit(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (value.length != 1 || !RegExp(r'[0-9]').hasMatch(value)) {
      return '';
    }
    return null;
  }
}
