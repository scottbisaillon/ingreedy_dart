// ignore_for_file: avoid_dynamic_calls

import 'package:ingreedy_dart/src/models/models.dart';
import 'package:petitparser/petitparser.dart';

/// Map of written (word) number values to an [int].
const numberValue = {
  'a': 1,
  'an': 1,
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
  'ten': 10,
  'eleven': 11,
  'twelve': 12,
  'thirteen': 13,
  'fourteen': 14,
  'fifteen': 15,
  'sixteen': 16,
  'seventeen': 17,
  'eighteen': 18,
  'nineteen': 19,
  'twenty': 20,
  'thirty': 30,
  'forty': 40,
  'fifty': 50,
  'sixty': 60,
  'seventy': 70,
  'eighty': 80,
  'ninety': 90
};

/// Map of unicode fraction values to a [double].
Map<String, double> unicodeFractionValue = {
  '¼': 1.0 / 4,
  '½': 1.0 / 2,
  '¾': 3.0 / 4,
  '⅐': 1.0 / 7,
  '⅑': 1.0 / 9,
  '⅒': 1.0 / 10,
  '⅓': 1.0 / 3,
  '⅔': 2.0 / 3,
  '⅕': 1.0 / 5,
  '⅖': 2.0 / 5,
  '⅗': 3.0 / 5,
  '⅘': 4.0 / 5,
  '⅙': 1.0 / 6,
  '⅚': 5.0 / 6,
  '⅛': 1.0 / 8,
  '⅜': 3.0 / 8,
  '⅝': 5.0 / 8,
  '⅞': 7.0 / 8
};

/// {@template ingredient_grammar}
/// A grammar definition for a string containing all the parts of a typical
/// recipe ingredient.
/// {@endtemplate}
class IngredientGrammar extends GrammarDefinition<Ingredient> {
  @override
  Parser<Ingredient> start() => ingredient().end();

  /// The starting parser.
  Parser<Ingredient> ingredient() => (ref0<dynamic>(multiPartQuantity) &
              ref0<dynamic>(alternateQuantity).optional() &
              ref0<dynamic>(wordBreak).optional() &
              ref0<dynamic>(ingredientFragment) &
              ref0<dynamic>(wordBreak).optional() &
              (any().starLazy(endOfInput()).flatten().trim()))
          .map<Ingredient>(
        (values) {
          return Ingredient(
            name: values[3] as String,
            quantities: values[0] as List<Quantity>,
            property:
                (values[5] as String).isNotEmpty ? values[5] as String : null,
          );
        },
      );

  /// Parser for multiple consecutive quantities.
  Parser<List<Quantity>> multiPartQuantity() => ref0<dynamic>(quantityFragment)
          .star()
          .castList<Quantity>()
          .map<List<Quantity>>((values) {
        final result = <Quantity>[];
        for (final quantity in values) {
          var updatedQuantity = quantity;
          if (result.isNotEmpty && result[0].unit == Unit.none) {
            updatedQuantity = quantity.copyWith(
              value: quantity.value * result[0].value,
            );
            result.clear();
          }
          result.add(updatedQuantity);
        }
        return result;
      });

  /// Parser for a single quantity portion of an ingredient.
  Parser<Quantity> quantityFragment() =>
      (ref0<dynamic>(quantity) | ref0<dynamic>(amount)).map<Quantity>(
        (dynamic value) => value is Quantity
            ? value
            : Quantity(value: double.parse(value.toString())),
      );

  /// Parser for an alternate quantity following the main one.
  /// ex: quantity1 / quantity2 ...rest of the ingredient
  Parser alternateQuantity() => char('/') & ref0<dynamic>(multiPartQuantity);

  /// Parser for all representations of a quantity.
  Parser<Quantity> quantity() => (ref0<dynamic>(amountWithConversion) |
          ref0<dynamic>(amountWithAttachedUnits) |
          ref0<dynamic>(amountWithMultiplier) |
          ref0<dynamic>(amountWithProperty))
      .cast<Quantity>();

  /// Parser for the ingredient portion.
  Parser<String> ingredientFragment() => any()
          .starLazy(char('(').trim() | char(',').trim() | endOfInput())
          .flatten()
          .trim()
          .map<String>(
        (value) {
          return value.startsWith('of')
              ? value.replaceFirst('of', '').replaceAll('  ', ' ').trim()
              : value.replaceAll('  ', ' ').trim();
        },
      );

  /* Amount Parsers */
  /// Parser for an amount with a following conversion.
  Parser<Quantity> amountWithConversion() => (ref0<dynamic>(amount) &
              ref0<dynamic>(unit) &
              ref0<dynamic>(parenthesizedQuantity))
          .map(
        (value) => Quantity(
          value: double.parse(value[0].toString()),
          unit: value[1] as Unit,
        ),
      );

  /// Parser for an amount with attached units.
  Parser<Quantity> amountWithAttachedUnits() => (ref0<dynamic>(amount) &
              ref0<dynamic>(seperator).optional() &
              ref0<dynamic>(unit))
          .map<Quantity>(
        (values) => Quantity(
          value: double.parse(values[0].toString()),
          unit: values[2] as Unit,
        ),
      );

  /// Parser for an amount with a following multiplier.
  Parser<Quantity> amountWithMultiplier() =>
      (ref0<dynamic>(amount) & ref0<dynamic>(parenthesizedQuantity)).map(
        (values) => Quantity(
          value: double.parse(values[0].toString()) *
              (values[1] as Quantity).value,
          unit: (values[1] as Quantity).unit,
        ),
      );

  /// Parser for an amount with a following property.
  Parser<Quantity> amountWithProperty() =>
      (ref0<dynamic>(amount) & ref0<dynamic>(parenthesizedProperty))
          .map<Quantity>(
        (values) => Quantity(
          value: double.parse(values[0].toString()),
          property: values[1] as String,
        ),
      );

  /// Parser for all representations of an amount.
  Parser amount() =>
      ref0<dynamic>(float) |
      ref0<dynamic>(mixedNumber) |
      ref0<dynamic>(fraction) |
      ref0<dynamic>(integer) |
      ref0<dynamic>(writtenNumber);

  /// Parser for a quantity in parentheses.
  Parser<Quantity> parenthesizedQuantity() => (char('(').trim() &
          ref0<dynamic>(amountWithAttachedUnits) &
          char(')').trim())
      .castList<Quantity>()
      .pick(1);

  /// Parser for a propery in parentheses.
  Parser<String> parenthesizedProperty() => (char('(').trim() &
          any().starLazy(char(')')).flatten() &
          char(')').trim())
      .map((value) => '${value[1]}'.trim());

  /* Number Parsers */
  /// Parses a mixed number of the format [# #/#] into a [double].
  Parser mixedNumber() => (ref0<dynamic>(integer) &
          ref0<dynamic>(seperator).optional() &
          ref0<dynamic>(fraction))
      .map<double>((value) => value[0] + (value[2] as double) as double);

  /// Parses an integer value into an [int].
  Parser integer() => digit().plus().flatten().trim().map<double>(double.parse);

  /// Parses a floating point value into a [double].
  Parser<double> float() =>
      (digit().plus().optional() & char('.') & digit().plus().optional())
          .flatten()
          .trim()
          .map<double>(double.parse);

  /// Parses a fraction represented as a [multiCharacterFraction] or
  /// [unicodeFraction] inta a [double].
  Parser<double> fraction() =>
      (ref0<double>(multiCharacterFraction) | ref0<double>(unicodeFraction))
          .map(
        (dynamic value) => value as double,
      );

  /// Parses a fraction represented by [#/#] into a [double].
  Parser<double> multiCharacterFraction() =>
      (ref0<dynamic>(integer) & char('/').trim() & ref0<dynamic>(integer))
          .map((values) => values[0] / values[2] as double);

  /// Parses an integer value represented by a word into an [int].
  Parser writtenNumber() => ((string('a') & whitespace()) |
          (string('an') & whitespace()) |
          (string('zero') & whitespace()) |
          (string('one') & whitespace()) |
          (string('two') & whitespace()) |
          (string('three') & whitespace()) |
          (string('four') & whitespace()) |
          (string('five') & whitespace()) |
          (string('six') & whitespace()) |
          (string('seven') & whitespace()) |
          (string('eight') & whitespace()) |
          (string('nine') & whitespace()) |
          (string('ten') & whitespace()) |
          (string('eleven') & whitespace()) |
          (string('twelve') & whitespace()) |
          (string('thirteen') & whitespace()) |
          (string('fourteen') & whitespace()) |
          (string('fifteen') & whitespace()) |
          (string('sixteen') & whitespace()) |
          (string('seventeen') & whitespace()) |
          (string('eighteen') & whitespace()) |
          (string('nineteen') & whitespace()) |
          (string('twenty') & whitespace()) |
          (string('thirty') & whitespace()) |
          (string('forty') & whitespace()) |
          (string('fifty') & whitespace()) |
          (string('sixty') & whitespace()) |
          (string('seventy') & whitespace()) |
          (string('eighty') & whitespace()) |
          (string('ninety') & whitespace()))
      .flatten()
      .trim()
      .map<double>(
        (values) => double.parse(numberValue[values.trim()]!.toString()),
      );

  /// Parses a unicode fraction into a [double].
  Parser<double> unicodeFraction() => (string('¼') |
          string('½') |
          string('¾') |
          string('⅐') |
          string('⅑') |
          string('⅒') |
          string('⅓') |
          string('⅔') |
          string('⅕') |
          string('⅖') |
          string('⅗') |
          string('⅘') |
          string('⅙') |
          string('⅚') |
          string('⅛') |
          string('⅜') |
          string('⅝') |
          string('⅞'))
      .flatten()
      .trim()
      .map<double>((value) => unicodeFractionValue[value]!);

  /* Unit Parsers */
  /// Parses a value into a [Unit].
  Parser unit() =>
      ref0<dynamic>(cup) |
      ref0<dynamic>(ounce) |
      ref0<dynamic>(fluidOunce) |
      ref0<dynamic>(gallon) |
      ref0<dynamic>(pound) |
      ref0<dynamic>(pint) |
      ref0<dynamic>(quart) |
      ref0<dynamic>(tablespoon) |
      ref0<dynamic>(teaspoon) |
      ref0<dynamic>(kiloCalorie) |
      ref0<dynamic>(calorie) |
      ref0<dynamic>(milligram) |
      ref0<dynamic>(gram) |
      ref0<dynamic>(kilogram) |
      ref0<dynamic>(joule) |
      ref0<dynamic>(kilojoule) |
      ref0<dynamic>(milliliter) |
      ref0<dynamic>(liter);

  /// Cup unit parser.
  Parser cup() => (string('cups').trim() |
          string('cup').trim() |
          string('c.').trim() |
          (string('c') & whitespace()).trim())
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.cup);

  /// FLuid ounce unit parser.
  Parser fluidOunce() => (ref0<dynamic>(fluid) & ref0<dynamic>(ounce))
      .map<Unit>((value) => Unit.flOunce);

  /// Fluid unit parser.
  Parser fluid() =>
      stringIgnoreCase('fluid') |
      stringIgnoreCase('fl.') |
      (stringIgnoreCase('fl') & whitespace());

  /// Ounce parser.
  Parser ounce() => (stringIgnoreCase('ounces') |
          stringIgnoreCase('ounce') |
          stringIgnoreCase('oz.') |
          stringIgnoreCase('oz'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.ounce);

  /// Gallon parser
  Parser gallon() => ((stringIgnoreCase('gallons') |
              stringIgnoreCase('gallon') |
              stringIgnoreCase('gal.') |
              (stringIgnoreCase('gal') & whitespace())) &
          char('.').optional())
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.gallon);

  /// Calorie parser.
  Parser calorie() => ((stringIgnoreCase('calories') |
              stringIgnoreCase('calorie') |
              stringIgnoreCase('cal')) &
          (whitespace() | endOfInput()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.calorie);

  /// Kilocalorie unit parser.
  Parser kiloCalorie() => ((stringIgnoreCase('kilocalories') |
              stringIgnoreCase('kilocalorie') |
              stringIgnoreCase('kCal') |
              stringIgnoreCase('kcal')) &
          (whitespace() | endOfInput()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.kiloCalorie);

  /// Pint unit parser.
  Parser pint() => (stringIgnoreCase('pints') |
          (stringIgnoreCase('pint') & whitespace()) |
          stringIgnoreCase('pt.') |
          stringIgnoreCase('pt'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.pint);

  /// Pound unit parser.
  Parser pound() => (stringIgnoreCase('pounds') |
          stringIgnoreCase('pound') |
          stringIgnoreCase('lbs.') |
          stringIgnoreCase('lbs') |
          stringIgnoreCase('lb.') |
          stringIgnoreCase('lb'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.pound);

  /// Quart unit parser.
  Parser quart() => (stringIgnoreCase('quarts') |
          stringIgnoreCase('quart') |
          stringIgnoreCase('qts.') |
          stringIgnoreCase('qts') |
          stringIgnoreCase('qt.') |
          stringIgnoreCase('qt'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.quart);

  /// Tablespoon unit parser.
  Parser tablespoon() => (stringIgnoreCase('tablespoons') |
          stringIgnoreCase('tablespoon') |
          stringIgnoreCase('tbsps') |
          stringIgnoreCase('tbsp.') |
          stringIgnoreCase('tbsp') |
          stringIgnoreCase('tbs.') |
          stringIgnoreCase('tbs') |
          string('T.') |
          (string('T') & whitespace()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.tablespoon);

  /// Teaspoon unit parser.
  Parser teaspoon() => (stringIgnoreCase('teaspoons') |
          stringIgnoreCase('teaspoon.') |
          stringIgnoreCase('teaspoon') |
          stringIgnoreCase('tsp.') |
          stringIgnoreCase('tsp') |
          string('t.') |
          (string('t') & whitespace()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.teaspoon);

  /// Gram unit parser.
  Parser<Unit> gram() => (string('grams') |
          string('gram') |
          string('gr.') |
          string('gr') |
          string('g.') |
          (char('g') & letter().not()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.gram);

  /// Joule unit parser.
  Parser joule() => (stringIgnoreCase('joules') |
          stringIgnoreCase('joule') |
          (stringIgnoreCase('j') & whitespace()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.joule);

  /// Kilogram unit parser.
  Parser kilogram() => (stringIgnoreCase('kilograms') |
          stringIgnoreCase('kilogram') |
          stringIgnoreCase('kg.') |
          stringIgnoreCase('kg'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.kiloGram);

  /// Kilojoule unit parser.
  Parser kilojoule() => (stringIgnoreCase('kilojoules') |
          stringIgnoreCase('kilojoule') |
          stringIgnoreCase('kJ') |
          stringIgnoreCase('kj'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.kiloJoule);

  /// Liter unit parser.
  Parser liter() => (stringIgnoreCase('liters') |
          stringIgnoreCase('liter') |
          stringIgnoreCase('l.') |
          (stringIgnoreCase('l') & whitespace()))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.liter);

  /// Milligram unit parser.
  Parser milligram() => (stringIgnoreCase('milligrams') |
          stringIgnoreCase('milligram') |
          stringIgnoreCase('mg.') |
          stringIgnoreCase('mg'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.milliGram);

  /// Milliliter unit parser.
  Parser milliliter() => (stringIgnoreCase('milliliters') |
          stringIgnoreCase('milliliter') |
          stringIgnoreCase('ml.') |
          stringIgnoreCase('ml'))
      .flatten()
      .trim()
      .map<Unit>((value) => Unit.milliLiter);

  /* Misc Parsers */
  /// Parser for space between words.
  Parser wordBreak() => (char(',') | char('-') | whitespace()).trim();

  /// Parser for common separators.
  Parser seperator() => char('-') | char(',') | string('and');
}
