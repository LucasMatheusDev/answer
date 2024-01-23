import 'package:answer/answer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' hide Answer;

abstract class _UseCase {
  Future<AnswerDefault<String>> getValue();
}

class MockUserCase extends Mock implements _UseCase {}

class CustomError extends AnswerError {
  CustomError()
      : super(
          message: 'message',
          code: 0,
        );
}

void main() {
  late MockUserCase mockUserCase;

  setUp(() {
    mockUserCase = MockUserCase();
  });
  group('answer Types ...', () {
    test('when call useCase with TypeDef, should return a Success', () async {
      when(() => mockUserCase.getValue())
          .thenAnswer((_) async => 'value'.asAnswer());
      final result = await mockUserCase.getValue();
      expect(result.isSuccess, true);
      final value = result.asSuccess;
      expect(value, 'value');
    });
    test('when call useCase with TypeDef, should return a Failure', () async {
      when(() => mockUserCase.getValue())
          .thenAnswer((_) async => CustomError().asAnswer());
      final result = await mockUserCase.getValue();
      expect(result.isFailure, true);
      final exception = result.asFailure;
      expect(exception, isA<Exception>());
    });
  });
}
