/// Formats investigator names for compact card layouts (first name line, last name line).
String formatInvestigatorNameForCard(String fullName) {
  final trimmed = fullName.trim();
  if (trimmed.isEmpty) return trimmed;

  final parts = trimmed.split(RegExp(r'\s+'));
  if (parts.length == 1) return trimmed;

  final lastName = parts.last;
  final firstPart = parts.sublist(0, parts.length - 1).join(' ');
  return '$firstPart\n$lastName';
}
