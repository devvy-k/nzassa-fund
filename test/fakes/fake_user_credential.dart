import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';


class FakeUser extends Fake implements User {
  @override
  String get uid => 'fake-uid';

  @override
  String get email => 'test@example.com';
}

class FakeUserCredential extends Fake implements UserCredential {

  @override
  User? get user => FakeUser();
}
