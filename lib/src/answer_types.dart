import 'package:answer/answer.dart';

class Success<F, S> extends Answer<F, S> {
  final S data;

  Success(this.data);
}

class Failure<F, S> extends Answer<F, S> {
  final F failure;

  Failure(this.failure);
}

typedef AnswerDefault<S> = Answer<AnswerError, S>;
