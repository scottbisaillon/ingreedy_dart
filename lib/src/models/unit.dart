/// {@template unit}
/// A representation of standard unit of measures associated with food.
/// {@endtemplate}
enum Unit {
  /// No specific unit.
  none('none'),

  /// Pint
  pint('pint'),

  /// Quart
  quart('quart'),

  /// Cup
  cup('cup'),

  /// Teaspoon
  teaspoon('tsp'),

  /// Tablespoon
  tablespoon('tbsp'),

  /// Ounce
  ounce('ounce'),

  /// Fluid Ounce
  flOunce('fl ounce'),

  /// Gallon
  gallon('gal'),

  /// Pound
  pound('lb'),

  /// Milligram
  milliGram('mg'),

  /// Gram
  gram('g'),

  /// Kilogram
  kiloGram('kg'),

  /// Milliliter
  milliLiter('mL'),

  /// Liter
  liter('L'),

  /// Joule
  joule('j'),

  /// Kilojoule
  kiloJoule('kj'),

  /// Callorie
  calorie('cal'),

  /// Kilocalorie
  kiloCalorie('kCal');

  /// {@macro unit}
  const Unit(this.value);

  /// The string representation of a [Unit].
  final String value;

  /// Maps a [String] value to the associated [Unit] value, or [Unit.none]
  /// if [value] does not match.
  static Unit fromString(String? value) {
    if (value == null) {
      return Unit.none;
    }

    for (final unit in Unit.values) {
      if (unit.value == value) {
        return unit;
      }
    }
    return Unit.none;
  }
}
