part of 'exchange.dart';

class InvalidFormat implements Exception {
  final String? message;

  InvalidFormat([this.message]);

  @override
  String toString() {
    return message ?? 'Invalid format';
  }
}
