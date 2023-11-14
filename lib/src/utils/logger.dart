import 'dart:developer' as devtools show log;

extension Logger on Object {
  void log() => devtools.log(toString());
}
