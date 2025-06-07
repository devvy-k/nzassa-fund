import 'package:crowfunding_project/core/data/datasources/auth_remote_datasource.dart';
import 'package:crowfunding_project/core/data/repositories/auth_repository_impl.dart';
import 'package:crowfunding_project/core/domain/repositories/auth_repository.dart';
import 'package:crowfunding_project/core/domain/usecases/auth/sign_in_usecase.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:crowfunding_project/ui/features/auth/auth_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fakes/fake_user_credential.dart';
import 'mock_auth_service.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late MockAuthService mockAuthService;
  late AuthRemoteDataSource authRemoteDataSource;
  late AuthRepository authRepository;
  late SignInUsecase signInUsecase;
  late AuthViewmodel authViewmodel;

  setUp(() {
    mockAuthService = MockAuthService();
    authRemoteDataSource = AuthRemoteDataSource(mockAuthService);
    authRepository = AuthRepositoryImpl(authRemoteDataSource);
    signInUsecase = SignInUsecase(authRepository);
    authViewmodel = AuthViewmodel(signInUsecase);
  });

  test('Sign in success sets error to null ', () async {
    // Arrange
    when(
      mockAuthService.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => FakeUserCredential());

    // Act
    await authViewmodel.signIn('test@example.com', 'password123');

    // Assert
    expect(authViewmodel.error, isNull);
    expect(authViewmodel.isLoading.value, isFalse);
  });

  test('Sign in failure sets error message', () async {
    // Arrange
    when(
      mockAuthService.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenThrow(Exception('Sign-in failed'));

    // Act
    await authViewmodel.signIn('test@example.com', 'wrongpassword');

    // Assert
    expect(authViewmodel.error?.value, contains('Sign-in failed'));
    expect(authViewmodel.isLoading.value, isFalse);
  });
}
