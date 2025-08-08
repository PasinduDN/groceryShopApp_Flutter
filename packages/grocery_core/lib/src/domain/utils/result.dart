// A generic class to handle success and failure states for your repository calls.
abstract class Result<S, E extends Exception> {
  const Result();
}

class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}