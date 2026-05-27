enum Role { voluntario, admin }

class LocalUser {
  final String name;
  final Role role;

  const LocalUser(this.name, this.role);
}
