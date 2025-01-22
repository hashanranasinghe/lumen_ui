class CLIException implements Exception {
  final String message;
  final String? helpText;
  final int exitCode;

  CLIException(this.message, {this.helpText, this.exitCode = 1});

  @override
  String toString() => message;
}