package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class RewriteTest {
	public var rewriter:Rewrite;

	@BeforeClass
	public function suiteSetup() {
		var config = {
			consonants: Consts.consonant_sets['Test'],
			vowels: Consts.vowel_sets['Test'],
			syllable_structure: Consts.syllable_structures[0],
			phrase_structure: Consts.phrase_structures[0]
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
		var expected = '([d]{1})[bcd]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePostFix() {
		var test = '_V';
		var expected = '([d]{1})[aeiou]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePostFixMultiple() {
		var test = '_VV';
		var expected = '([d]{1})[aeiou]{1}[aeiou]{1}';

		var out = rewriter.parseRule('d', test);

		Assert.areEqual(expected, out);
	}

	@Test
	public function parseRulePreFix() {
		var test = 'V_';
		var expected = '[aeiou]{1}([d]{1})';

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
}
