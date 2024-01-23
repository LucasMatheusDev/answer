import 'package:answer/src/answer_types.dart';

abstract class Answer<F, S> {
  /// Return the failure if this is a [Failure] or
  /// throw an [Exception] if this is a [Success].
  F get asFailure => (this as Failure<F, S>).failure;

  /// Return the success if this is a [Success] or
  /// throw an [Exception] if this is a [Failure].
  S get asSuccess => (this as Success<F, S>).data;

  /// True if this is a [Success] type.
  bool get isSuccess => this is Success<F, S>;

  /// True if this is a [Failure] type.
  bool get isFailure => this is Failure<F, S>;

  /// Handle the [Failure] or [Success] with the given functions.
  /// Example:
  /// ```dart
  /// final bool isError = answer.deal(
  ///  onFail: (failure) => true,
  ///  onSuccess: (success) => false,
  /// );
  /// ```
  R deal<R>({
    required R Function(F failure) onFail,
    required R Function(S success) onSuccess,
  }) {
    return this is Failure<F, S>
        ? onFail(
            (this as Failure<F, S>).failure,
          )
        : onSuccess(
            (this as Success<F, S>).data,
          );
  }

  Answer();

  /// Create a [Failure] Answer.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///    final answer = await someAsyncFunction();
  ///   return Answer.success(answer);
  /// } catch (e) {
  ///  return Answer.fail(e);
  /// }
  /// ```
  factory Answer.fail(F failure) {
    return Failure(failure);
  }

  /// Create a [Success] Answer.
  ///
  /// Example:
  /// ```dart
  /// try {
  ///    final answer = await someAsyncFunction();
  ///   return Answer.success(answer);
  /// } catch (e) {
  ///  return Answer.fail(e);
  /// }
  /// ```
  factory Answer.success(S data) {
    return Success(data);
  }
}
