// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars
import 'package:ingreedy_dart/src/ingreedy_dart.dart';
import 'package:ingreedy_dart/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('IngreedyDart', () {
    final testValues = <String, Ingredient>{
      '1.0 cup flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      '1 1/2 cups flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1.5, unit: Unit.cup)],
      ),
      '1 1/2 potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 1.5)],
      ),
      '12345 potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 12345)],
      ),
      '1 2/3 cups flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1 + 2 / 3, unit: Unit.cup)],
      ),
      '12 (6-ounce) boneless skinless chicken breasts': Ingredient(
        name: 'boneless skinless chicken breasts',
        quantities: const [Quantity(value: 72, unit: Unit.ounce)],
      ),
      '1 (28 ounce) can crushed tomatoes': Ingredient(
        name: 'can crushed tomatoes',
        quantities: const [Quantity(value: 28, unit: Unit.ounce)],
      ),
      '1/2 cups flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 0.5, unit: Unit.cup)],
      ),
      '12g potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 12, unit: Unit.gram)],
      ),
      '12oz potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 12, unit: Unit.ounce)],
      ),
      '12oz tequila': Ingredient(
        name: 'tequila',
        quantities: const [Quantity(value: 12, unit: Unit.ounce)],
      ),
      '1/2 potato': Ingredient(
        name: 'potato',
        quantities: const [Quantity(value: 0.5)],
      ),
      '1.5 cups flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1.5, unit: Unit.cup)],
      ),
      '1.5 potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 1.5)],
      ),
      '1 clove garlic, minced': Ingredient(
        name: 'clove garlic',
        quantities: const [Quantity(value: 1)],
        property: 'minced',
      ),
      '1 cup flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      '1 garlic clove, sliced in 1/2': Ingredient(
        name: 'garlic clove',
        quantities: const [Quantity(value: 1)],
        property: 'sliced in 1/2',
      ),
      '1 tablespoon (3 teaspoons) Sazon seasoning blend (recommended: Goya) with Mexican and Spanish foods in market':
          Ingredient(
        name: 'Sazon seasoning blend',
        quantities: const [Quantity(value: 1, unit: Unit.tablespoon)],
        property:
            '(recommended: Goya) with Mexican and Spanish foods in market',
      ),
      '2 (28 ounce) can crushed tomatoes': Ingredient(
        name: 'can crushed tomatoes',
        quantities: const [Quantity(value: 56, unit: Unit.ounce)],
      ),
      '.25 cups flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 0.25, unit: Unit.cup)],
      ),
      '2 cups of potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 2, unit: Unit.cup)],
      ),
      '2 eggs, beaten': Ingredient(
        name: 'eggs',
        quantities: const [Quantity(value: 2)],
        property: 'beaten',
      ),
      '3 28 ounce cans of crushed tomatoes': Ingredient(
        name: 'cans of crushed tomatoes',
        quantities: const [Quantity(value: 84, unit: Unit.ounce)],
      ),
      // '5 3/4 pinches potatoes': Ingredient(name: 'potatoes',quantities: Quantity(value: 5.75 , unit: Unit.pinch),	),
      '.5 potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 0.5)],
      ),
      'a cup of flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      // 'ground black pepper to taste': Ingredient(name: 'ground black pepper to taste',),
      'one 28 ounce can crushed tomatoes': Ingredient(
        name: 'can crushed tomatoes',
        quantities: const [Quantity(value: 28, unit: Unit.ounce)],
      ),
      'one cup flour': Ingredient(
        name: 'flour',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      'three 28 ounce cans crushed tomatoes': Ingredient(
        name: 'cans crushed tomatoes',
        quantities: const [Quantity(value: 84, unit: Unit.ounce)],
      ),
      'two 28 ounce cans crushed tomatoes': Ingredient(
        name: 'cans crushed tomatoes',
        quantities: const [Quantity(value: 56, unit: Unit.ounce)],
      ),
      'two five ounce can crushed tomatoes': Ingredient(
        name: 'can crushed tomatoes',
        quantities: const [Quantity(value: 10, unit: Unit.ounce)],
      ),
      '1kg / 2lb 4oz potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [Quantity(value: 1, unit: Unit.kiloGram)],
      ),
      '2lb 4oz potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [
          Quantity(value: 2, unit: Unit.pound),
          Quantity(value: 4, unit: Unit.ounce)
        ],
      ),
      '2lb 4oz (1kg) potatoes': Ingredient(
        name: 'potatoes',
        quantities: const [
          Quantity(value: 2, unit: Unit.pound),
          Quantity(value: 4, unit: Unit.ounce)
        ],
      ),
      '1-1/2 ounce vanilla ice cream': Ingredient(
        name: 'vanilla ice cream',
        quantities: const [Quantity(value: 1.5, unit: Unit.ounce)],
      ),
      '1-½ ounce vanilla ice cream': Ingredient(
        name: 'vanilla ice cream',
        quantities: const [Quantity(value: 1.5, unit: Unit.ounce)],
      ),
      // 'apple': Ingredient(name: 'apple',	),
      '3-⅝ ounces, weight feta cheese, crumbled/diced': Ingredient(
        name: 'weight feta cheese',
        quantities: const [Quantity(value: 3.625, unit: Unit.ounce)],
        property: 'crumbled/diced',
      ),
      '16-ounce can of sliced pineapple': Ingredient(
        name: 'can of sliced pineapple',
        quantities: const [Quantity(value: 16, unit: Unit.ounce)],
      ),
      '750ml/1 pint 7fl oz hot vegetable stock': Ingredient(
        name: 'hot vegetable stock',
        quantities: const [Quantity(value: 750, unit: Unit.milliLiter)],
      ),
      // 'pinch salt': Ingredient(name: 'salt',quantities: Quantity(value: 1 , unit: Unit.pinch),	),
      '4 (16 ounce) t-bone steaks, at room temperature': Ingredient(
        name: 't-bone steaks',
        quantities: const [Quantity(value: 64, unit: Unit.ounce)],
        property: 'at room temperature',
      ),
      '5 g': Ingredient(
        name: '',
        quantities: const [Quantity(value: 5, unit: Unit.gram)],
      ),
      '30 cal': Ingredient(
        name: '',
        quantities: const [Quantity(value: 30, unit: Unit.calorie)],
      ),
      '2.5 kcal': Ingredient(
        name: '',
        quantities: const [Quantity(value: 2.5, unit: Unit.kiloCalorie)],
      ),
      '50 joules': Ingredient(
        name: '',
        quantities: const [Quantity(value: 50, unit: Unit.joule)],
      ),
      '1 kJ': Ingredient(
        name: '',
        quantities: const [Quantity(value: 1, unit: Unit.kiloJoule)],
      ),
      '20 gallons.': Ingredient(
        name: '',
        quantities: const [Quantity(value: 20, unit: Unit.gallon)],
      ),
      '6 (thinly sliced) bananas': Ingredient(
        name: 'bananas',
        quantities: const [
          Quantity(
            value: 6,
            property: 'thinly sliced',
          )
        ],
      ),
      '6 (1/2 inch thick) slices Italian bread': Ingredient(
        name: 'slices Italian bread',
        quantities: const [
          Quantity(
            value: 6,
            property: '1/2 inch thick',
          )
        ],
      ),
      '6 pounds Butternut Squash ( peeled, deseeded and roasted see instructions and notes)':
          Ingredient(
        name: 'Butternut Squash',
        property: '( peeled, deseeded and roasted see instructions and notes)',
        quantities: const [Quantity(value: 6, unit: Unit.pound)],
      ),
      '2 Tablespoons oil, divided - coconut or other high heat oil such as avocado or sunflower':
          Ingredient(
        name: 'oil',
        property:
            'divided - coconut or other high heat oil such as avocado or sunflower',
        quantities: const [Quantity(value: 2, unit: Unit.tablespoon)],
      ),
      '1 Tablespoon butter': Ingredient(
        name: 'butter',
        quantities: const [Quantity(value: 1, unit: Unit.tablespoon)],
      ),
      '1 teaspoon ground nutmeg': Ingredient(
        name: 'ground nutmeg',
        quantities: const [Quantity(value: 1, unit: Unit.teaspoon)],
      ),

      '½ teaspoon ground cloves': Ingredient(
        name: 'ground cloves',
        quantities: const [Quantity(value: 0.5, unit: Unit.teaspoon)],
      ),
      '1 cup yellow onion, diced (150g)': Ingredient(
        name: 'yellow onion',
        property: 'diced (150g)',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      '1 cup carrot, peeled and diced (150g)': Ingredient(
        name: 'carrot',
        property: 'peeled and diced (150g)',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      '1 cup celery, diced (100g)': Ingredient(
        name: 'celery',
        property: 'diced (100g)',
        quantities: const [Quantity(value: 1, unit: Unit.cup)],
      ),
      '1 teaspoon kosher salt': Ingredient(
        name: 'kosher salt',
        quantities: const [Quantity(value: 1, unit: Unit.teaspoon)],
      ),
      '1 teaspoon ground black pepper': Ingredient(
        name: 'ground black pepper',
        quantities: const [Quantity(value: 1, unit: Unit.teaspoon)],
      ),
      '3 cups chicken stock (can also use vegetable stock) (750 ml)':
          Ingredient(
        name: 'chicken stock',
        property: '(can also use vegetable stock) (750 ml)',
        quantities: const [Quantity(value: 3, unit: Unit.cup)],
      ),
      '3 cloves garlic, peeled and minced': Ingredient(
        name: 'cloves garlic',
        property: 'peeled and minced',
        quantities: const [Quantity(value: 3)],
      ),
      '1 teaspoon. brown sugar': Ingredient(
        name: 'brown sugar',
        quantities: const [Quantity(value: 1, unit: Unit.teaspoon)],
      ),
      '4 cups heavy cream ( can also use coconut milk) (1000 ml)': Ingredient(
        name: 'heavy cream',
        property: '( can also use coconut milk) (1000 ml)',
        quantities: const [Quantity(value: 4, unit: Unit.cup)],
      ),
      '1 teaspoon fish sauce (optional - adds a nice umami flavor, not fishy at all)':
          Ingredient(
        name: 'fish sauce',
        property: '(optional - adds a nice umami flavor, not fishy at all)',
        quantities: const [Quantity(value: 1, unit: Unit.teaspoon)],
      )
    };

    group('parseSingle', () {
      for (final entry in testValues.entries) {
        test(
          "when given '${entry.key}' should return [${entry.value}]",
          () {
            final result = Ingreedy.parseSingle(entry.key);
            expect(result, isNotNull);
            expect(result, equals(entry.value));
          },
        );
      }
    });

    group('parseList', () {
      const inputValues = [
        '1 tablespoon extra virgin olive oil',
        '1 1/4 pound lean ground turkey',
        '1 small sweet onion , diced',
        '15 ounce can diced tomatoes , undrained',
        '6 ounces green beans , cut into 2-inch pieces (about 1 1/2 cups)',
        '1 1/2 cups short grain white rice',
        '2 1/2 cups low sodium chicken broth',
        '1 teaspoon coarse salt',
        '1/4 teaspoon black pepper',
        '1/4 teaspoon garlic powder',
        '1/2 teaspoon dried Italian herbs',
        '1/8 teaspoon cracked red pepper flakes',
        '2 teaspoons grainy mustard',
        '2 teaspoons worcestershire sauce',
      ];

      const outputValues = {
        '1 tablespoon extra virgin olive oil': Ingredient(
          name: 'extra virgin olive oil',
          quantities: [Quantity(value: 1, unit: Unit.tablespoon)],
        ),
        '1 1/4 pound lean ground turkey': Ingredient(
          name: 'lean ground turkey',
          quantities: [Quantity(value: 1 + 1 / 4, unit: Unit.pound)],
        ),
        '1 small sweet onion , diced': Ingredient(
          name: 'small sweet onion',
          quantities: [Quantity(value: 1)],
          property: 'diced',
        ),
        '15 ounce can diced tomatoes , undrained': Ingredient(
          name: 'can diced tomatoes',
          quantities: [Quantity(value: 15, unit: Unit.ounce)],
          property: 'undrained',
        ),
        '6 ounces green beans , cut into 2-inch pieces (about 1 1/2 cups)':
            Ingredient(
          name: 'green beans',
          quantities: [Quantity(value: 6, unit: Unit.ounce)],
          property: 'cut into 2-inch pieces (about 1 1/2 cups)',
        ),
        '1 1/2 cups short grain white rice': Ingredient(
          name: 'short grain white rice',
          quantities: [Quantity(value: 1 + 1 / 2, unit: Unit.cup)],
        ),
        '2 1/2 cups low sodium chicken broth': Ingredient(
          name: 'low sodium chicken broth',
          quantities: [Quantity(value: 2 + 1 / 2, unit: Unit.cup)],
        ),
        '1 teaspoon coarse salt': Ingredient(
          name: 'coarse salt',
          quantities: [Quantity(value: 1, unit: Unit.teaspoon)],
        ),
        '1/4 teaspoon black pepper': Ingredient(
          name: 'black pepper',
          quantities: [Quantity(value: 1 / 4, unit: Unit.teaspoon)],
        ),
        '1/4 teaspoon garlic powder': Ingredient(
          name: 'garlic powder',
          quantities: [Quantity(value: 1 / 4, unit: Unit.teaspoon)],
        ),
        '1/2 teaspoon dried Italian herbs': Ingredient(
          name: 'dried Italian herbs',
          quantities: [Quantity(value: 1 / 2, unit: Unit.teaspoon)],
        ),
        '1/8 teaspoon cracked red pepper flakes': Ingredient(
          name: 'cracked red pepper flakes',
          quantities: [Quantity(value: 1 / 8, unit: Unit.teaspoon)],
        ),
        '2 teaspoons grainy mustard': Ingredient(
          name: 'grainy mustard',
          quantities: [Quantity(value: 2, unit: Unit.teaspoon)],
        ),
        '2 teaspoons worcestershire sauce': Ingredient(
          name: 'worcestershire sauce',
          quantities: [Quantity(value: 2, unit: Unit.teaspoon)],
        ),
      };

      test('should parse list ingredients', () {
        expect(
          Ingreedy.parseList(inputValues),
          equals(outputValues),
        );
      });
    });

    const input = '1 teaspoon. brown sugar';
    const output = Ingredient(
      name: 'brown sugar',
      quantities: [Quantity(value: 1, unit: Unit.teaspoon)],
    );

    test(
      "when given '$input' should return [$output]",
      () {
        final result = Ingreedy.parseSingle(input);
        expect(result, isNotNull);
        expect(result, equals(output));
      },
    );
  });
}
