import 'package:salvando_vidas/main_imports.dart';

bool eEmail(String email) {
  final clean = email.trim();
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");
  return exp.hasMatch(clean);
}

bool eTelefone(String telefone) {
  final clean = telefone.replaceAll(RegExp(r'[^0-9]'), '');
  return clean.length >= 10 && clean.length <= 11;
}

bool eCPF(String cpf) {
  final clean = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  if (clean.length != 11) return false;

  switch (clean) {
    case "00000000000":
    case "11111111111":
    case "22222222222":
    case "33333333333":
    case "44444444444":
    case "55555555555":
    case "66666666666":
    case "77777777777":
    case "88888888888":
    case "99999999999":
    case "01234567890":
      return false;
  }

  List<int> digitos = [];
  for (final digito in clean.characters) {
    digitos.add(int.parse(digito));
  }

  int soma1 = 0;
  for (var i = 0; i < 9; i++) {
    soma1 += digitos[i] * (10 - i);
  }

  int resto1 = soma1 % 11;
  int ver1 = (resto1 < 2) ? 0 : (11 - resto1);
  if (digitos[9] != ver1) return false;

  int soma2 = 0;
  for (var i = 0; i < 10; i++) {
    soma2 += digitos[i] * (11 - i);
  }

  int resto2 = soma2 % 11;
  int ver2 = (resto2 < 2) ? 0 : (11 - resto2);
  if (digitos[10] != ver2) return false;

  return true;
}
