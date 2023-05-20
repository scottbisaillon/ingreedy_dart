import 'package:ingreedy_dart/src/ingredient_grammar.dart';
import 'package:ingreedy_dart/src/models/models.dart';

/// {@template ingreedy}
/// A recipe ingredient parser.
/// {@endtemplate}
class Ingreedy {
  /// Parses a single ingredient from the input.
  static Ingredient? parseSingle(String ingredient) {
    final result = IngredientGrammar().build<Ingredient>().parse(ingredient);
    return result.isSuccess ? result.value : null;
  }

  /// Parses multiple ingredients.
  static Map<String, Ingredient?> parseList(Iterable<String> ingredients) =>
      {for (var ingredient in ingredients) ingredient: parseSingle(ingredient)};
}
