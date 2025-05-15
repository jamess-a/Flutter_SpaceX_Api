abstract class Failure {
  final String? message;

  Failure([this.message]);

  @override
  String toString() => message ?? runtimeType.toString();
}

class ServerFailure extends Failure {
  ServerFailure([super.message]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ServerFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message]);
}
