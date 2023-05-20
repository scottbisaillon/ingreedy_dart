import 'package:equatable/equatable.dart';
import 'package:ingreedy_dart/src/models/models.dart';

/// {@template quantity}
/// A model representing the quantity of an ingredient
/// {@endtemplate}
class Quantity extends Equatable {
  /// {@macro quantity}
  const Quantity({
    required this.value,
    this.unit = Unit.none,
    this.property,
  });

  /// The value associated with this [Quantity].
  final double value;

  /// The unit associated with this [Quantity].
  final Unit? unit;

  /// An optional property associated with this [Quantity].
  final String? property;

  @override
  List<Object?> get props => [value, unit, property];

  @override
  String toString() =>
      'Quantity(value: $value, unit: $unit, property: $property)';

  /// Creates a copy with the specified values.
  Quantity copyWith({
    double? value,
    Unit? unit,
    String? property,
  }) {
    return Quantity(
      value: value ?? this.value,
      unit: unit ?? this.unit,
      property: property ?? this.property,
    );
  }
}
