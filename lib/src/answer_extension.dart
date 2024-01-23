import 'package:answer/src/answer.dart';

extension AnswerExtension on Object {
  /// Implicitly returns the response object as a Failure or Success.
  /// If the object does not match one of the [Answer] Types an exception will be thrown
  ///
  /// Example:
  /// ```dart
  /// Answer<AnswerError, bool> function() async {
  ///   try {
  ///     final answer = await someAsyncFunction();
  ///     return answer.asAnswer();
  ///   } catch (e) {
  ///     return e.asAnswer();
  ///   }
  /// }
  /// ```
  Answer<F, S> asAnswer<F, S>() {
    assert(
      this is F || this is S,
      "Expected ${F.toString()} or ${S.toString()} but got $runtimeType",
    );
    if (this is S) {
      return Answer.success(this as S);
    } else if (this is F) {
      return Answer.fail(this as F);
    } else {
      throw Exception(
        "Expected ${F.toString()} or ${S.toString()} but got $runtimeType",
      );
    }
  }
}
