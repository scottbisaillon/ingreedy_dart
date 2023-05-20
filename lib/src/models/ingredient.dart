import 'package:equatable/equatable.dart';
import 'package:ingreedy_dart/src/models/models.dart';

/// {@template ingredient}
/// A model representing the properties of a typical ingredient.
/// {@endtemplate}
class Ingredient extends Equatable {
  /// {@macro ingredient}
  const Ingredient({
    required this.name,
    required this.quantities,
    this.property,
  });

  /// The name of the [Ingredient].
  final String name;

  /// All quantities associated with this [Ingredient].
  final List<Quantity> quantities;

  /// Optional property associated with this [Ingredient].
  final String? property;

  @override
  List<Object?> get props => [name, quantities, property];

  @override
  String toString() =>
      'Ingredient(name: $name, quantities: $quantities, property: $property)';
}
