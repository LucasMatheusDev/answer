import 'dart:developer';

abstract class AnswerFailure implements Exception {
  final String message;
  final int code;
  final StackTrace? stackTrace;
  final Object? error;

  AnswerFailure({
    required this.message,
    required this.code,
    this.stackTrace,
    this.error,
    bool enableLog = true,
  }) {
    if (enableLog) {
      log(toString());
    }
  }

  @override
  String toString() {
    return "StackTrace: "
        "${stackTrace ?? formattedStackTrace()} \n "
        "Error: ${error.toString()} \n "
        "Code: $code \n "
        "Message: $message, \n "
        "AnswerError: $runtimeType \n "
        "Hour: ${DateTime.now()} \n ";
  }

  StackTrace? formattedStackTrace() {
    if (error is Error) {
      return (error as Error).stackTrace;
    } else {
      return StackTrace.current;
    }
  }
}
