class AppInputValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe seu e-mail";
    }
    if (!RegExp(
      r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$",
    ).hasMatch(value)) {
      return "E-mail inválido";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe sua senha";
    }
    if (value.length < 6) {
      return "A senha deve ter pelo menos 6 caracteres";
    }
    return null;
  }
}
