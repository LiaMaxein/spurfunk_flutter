import 'package:flutter_test/flutter_test.dart';
import 'package:spurfunk_flutter/core/utils/investigator_name_format.dart';

void main() {
  test('formatInvestigatorNameForCard breaks after first name part', () {
    expect(
      formatInvestigatorNameForCard('Klaus Borowski'),
      'Klaus\nBorowski',
    );
    expect(
      formatInvestigatorNameForCard('Sarah Brandt'),
      'Sarah\nBrandt',
    );
    expect(
      formatInvestigatorNameForCard('Prof. Karl-Friedrich Boerne'),
      'Prof. Karl-Friedrich\nBoerne',
    );
    expect(
      formatInvestigatorNameForCard('Peter Michael Schnabel'),
      'Peter Michael\nSchnabel',
    );
  });
}
