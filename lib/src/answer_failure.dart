import 'dart:developer';

/// Pattern error failure
abstract class AnswerFailure implements Exception {
  final String message;
  final int code;
  final StackTrace? stackTrace;
  final Object? error;

  AnswerFailure({
    required this.message,
    required this.code,

    /// When [stackTrace] is null, the current stack trace is used.
    this.stackTrace,
    this.error,

    /// Recommended set to [false] in production
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
