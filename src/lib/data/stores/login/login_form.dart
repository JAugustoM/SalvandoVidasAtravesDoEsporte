import 'package:mobx/mobx.dart';

part 'login_form.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';
}
