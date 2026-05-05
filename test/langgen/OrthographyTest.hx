package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class OrthographyTest {
	public var orthography:Orthography;

	@Before
	public function setup() {
		orthography = new Orthography({
			consonants: Consts.corthsets['Default'],
			vowels: Consts.vorthsets['Default'],
		});
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(orthography);
	}

	@Test
	public function testOrthos() {
		var cControl = 'd';
		var cTest = "ʃ".split("")[0];
		var vTest = "A";
		var vControl = "a";

		Assert.areEqual(cControl, orthography.getOrthoChar(cControl));
		Assert.areEqual('sh', orthography.getOrthoChar(cTest));
		Assert.areEqual(vControl, orthography.getOrthoChar(vControl));
		Assert.areEqual('á', orthography.getOrthoChar(vTest));
	}

	@Test
	public function testSpelling() {
		var before = "aʃ";
		var after = orthography.spell(before);
		var expected = "ash";

		Assert.areEqual(expected, after);
	}

	@Test
	public function spellingWithNoOverrideIsPassthrough() {
		var result = orthography.spell("abc");

		Assert.areEqual("abc", result);
	}

	@Test
	public function seededOrthographyIsDeterministic() {
		var o1 = new Orthography(null, "42");
		var o2 = new Orthography(null, "42");

		Assert.areEqual(o1.spell("aʃ"), o2.spell("aʃ"));
	}
}
