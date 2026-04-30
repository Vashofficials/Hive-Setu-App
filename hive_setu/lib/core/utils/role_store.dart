class RoleStore {
  RoleStore._();

  static String _current = 'beekeeper';

  static void set(String role) => _current = role;
  static String get current => _current;

  static bool get isBeekeeper => _current == 'beekeeper';
  static bool get isCollector => _current == 'collector';
  static bool get isBuyer => _current == 'buyer';
  static bool get isFpo => _current == 'fpo';
  static bool get isFieldOfficer => _current == 'field_officer';
}
