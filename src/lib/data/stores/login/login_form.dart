import 'package:mobx/mobx.dart';

part 'login_form.g.dart';

bool isEmail(String email) {
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");

  return exp.hasMatch(email);
}

// ignore: library_private_types_in_public_api
class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  final LoginFormErrorState error = LoginFormErrorState();

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  bool get canLogin => !error.hasErrors;

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : 'Não é um email válido';
  }

  @action
  void validatePassword(String value) {
    error.password = value.isNotEmpty ? null : 'Não pode estar em branco';
  }

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

// ignore: library_private_types_in_public_api
class LoginFormErrorState = _LoginFormErrorState with _$LoginFormErrorState;

abstract class _LoginFormErrorState with Store {
  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => email != null || password != null;
}
