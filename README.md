
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
   Future<Answer<AnswerError, String>> getUserId() async {
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
    Future<Answer<AnswerError, String>> getUserId() async {
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

# Recommended you use AnswerError
AnswerError class for Standardize your errors return

## Create your Specific from AnswerError

```dart
class MyError extends AnswerError {
  MyError() : super(
          message: 'MyError',
          code: 1,
        );
}
```

##  How add Answer return in your code

```dart
   Future<Answer<AnswerError, String>> getUserId() async {
    try {
        final result = await loginDatasource.getUserId();
        return Answer.success(result);
    } catch (e) {
        return Answer.fail(MyError());
    }
  }
```

## Handler your custom AnswerError

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








#   a n s w e r  
 