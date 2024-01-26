
# Answer
The Answer package simplifies the handling of function returns by allowing them to return either a success or an error object. This enhances code readability and makes error handling more structured.

#  How to use
To use the package in your Flutter project, simply add the dependency to your pubspec.yaml:

```yaml
dependencies:
  answer: ^0.0.1
```


Import the package in your code:

```dart
import 'package:answer/answer.dart';
```

#  How add Answer return in your code

```dart
   Future<Answer<AnswerFailure, String>> getUserId() async {
    try {
        final result = await loginDatasource.getUserId();
        return Answer.success(result);
    } catch (e) {
        return Answer.fail(e);
    }
  }
```

## With extension Answer
    
```dart
    Future<Answer<AnswerFailure, String>> getUserId() async {
        try {
            final result = await loginDatasource.getUserId();
            return result.asAnswer();
        } catch (e) {
            return e.asAnswer();
        }
    }
```


#  How handler Answer return in your code

## Void function
```dart
  Future<void> login() async {
    final answer = await getUserId();
    answer.deal(
      onSuccess: (idUser) {
        print(idUser);
      },
      onError: (error) {
        print(error);
      },
    );
  }
```

## Function with return
```dart
  Future<String> login() async {
    final answer = await getUserId();
    return answer.deal(
      onSuccess: (idUser) {
        return idUser;
      },
      onError: (error) {
        return error.message;
      },
    );
  }
```

# Recommended you use AnswerFailure
We recommend that you use the class *AnswerFailure* as the default response for *Failure*, this guarantees that your returns will always have a pattern, if you need a specific error, create a new error extending the class *Answer Failure*

## Create your Specific from AnswerFailure

```dart
class MyError extends AnswerFailure {
  MyError() : super(
          message: 'MyError',
          code: 1,
        );
}
```

##  How add Answer return in your code
Add *AnswerFailure* as your return in case of errors

```dart
   Future<Answer<AnswerFailure, String>> getUserId() async {
    try {
        final result = await loginDatasource.getUserId();
        return Answer.success(result);
    } catch (e) {
        return Answer.fail(MyError());
    }
  }
```

## Handler your custom AnswerFailure

```dart
  Future<void> login() async {
    final answer = await getUserId();
    answer.deal(
      onSuccess: (idUser) {
        print(idUser);
      },
      onError: (error) {
        if (error is MyError) {
          print(error.message);
        }else{
          print(error.message);
        }
      },
    );
  }
```

## You also can use AnswerDefault to simplify your code
You can also use *TypeDef* *AnswerDefault* simplifying the parameters, it by default returns *AnswerFailure* and you just need to pass the success object

```dart
   Future<AnswerDefault<String>> getUserId() async {
    try {
        final result = await loginDatasource.getUserId();
        return Answer.success(result);
    } catch (e) {
        return Answer.fail(e);
    }
  }
```

# Recommended on tests
Some *Mocks* libraries for testing contain import name conflicts, in these cases it is recommended that you import the *Mocks* library with the **Hide Answer** instruction.

## Example
```dart
import 'package:answer/answer.dart';
import 'package:mocktail/mocktail.dart' hide Answer;

void main() {
  test('test', () {
      ...
  });
}
```