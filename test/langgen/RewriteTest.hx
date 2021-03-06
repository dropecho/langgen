package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class RewriteTest {
	public var rewriter:Rewrite;

	@Before
	public function setup() {
		var config = {
			syllable_structure: Consts.syllable_structures[0],
			phrase_structure: Consts.phrase_structures[0],
			consonants: Consts.consonant_sets['Minimal'],
			vowels: Consts.vowel_sets['Default'],
			finals: [],
			sibilants: [],
			liquids: [],
			rewriteset: [],
			word_length_min: 1,
			word_length_max: 5
		};

		rewriter = new Rewrite(config);
	}

	@Test
	public function canGetSet() {
		Assert.isNotNull(rewriter);
	}

	@Test
	public function parseRuleConsonant() {
		var test = '_C';
		var expected = '(d)[ptkmnls]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePostFix() {
		var test = '_V';
		var expected = '(d)[aeiou]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePostFixMultiple() {
		var test = '_VV';
		var expected = '(d)[aeiou]{1}[aeiou]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePreFix() {
		var test = 'V_';
		var expected = '[aeiou]{1}(d)';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function testRule() {
		var test = 'V_';
		var out = rewriter.parseRule('d', test);

		var regex = new EReg(out, '');
		var before = 'reged';
		var expected = 'regid';

		var after = regex.replace(before, 'id');

		Assert.areEqual(expected, after);
	}

	@Test
	public function addRule() {
		rewriter.addRule("d", "_V", "de");

		var keys = [for (k in rewriter.rules.keys()) k];

		Assert.areEqual(1, keys.length);
	}

	@Test
	public function runRules() {
		rewriter.addRule("d", "_V", "de");

		var before = 'regdi';
		var expected = 'regde';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function moreSpecificRule() {
		var rule = rewriter.parseRule("d", "_im");
		rewriter.addRule("d", "_im", "de");

		var before = 'regdim';
		var expected = 'regde';

		var after = rewriter.rewrite(before);

		Assert.areEqual("(d)im", rule);
		Assert.areEqual(expected, after);
	}

	@Test public function doubleLetter() {
		rewriter.addRule("oo", "_", "u");

		var before = 'roog';
		var expected = 'rug';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function beginning_of_word() {
		rewriter.addRule("oo", "^_", "u");

		var before = 'ooroog';
		var expected = 'uroog';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function end_of_word() {
		rewriter.addRule("oo", "_$", "u");

		var before = 'roogoo';
		var expected = 'roogu';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function end_of_word_2() {
		rewriter.addRule("oo", "_(V)$", '$2');

		var before = 'roogooi';
		var expected = 'roogi';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function raw_rule() {
		// replace double chars with D
		rewriter.addRule("", "(.)\\1", "D");

		var before = 'roogooi';
		var expected = 'rDgDi';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function raw_rule_2() {
		// replace double chars with single of same char
		rewriter.addRule("", "(.)\\1", '$1');

		var before = 'rooguui';
		var expected = 'rogui';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}

	@Test public function raw_rule_3() {
		// replace double chars with single char
		var rule = Consts.rewritesets.get("No double sounds")[0];
		rewriter.addRule(rule.character, rule.rule, rule.replaceWith);

		var before = 'rooguui';
		var expected = 'rogui';

		var after = rewriter.rewrite(before);

		Assert.areEqual(expected, after);
	}
}
