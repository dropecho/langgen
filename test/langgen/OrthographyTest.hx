package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class OrthographyTest {
	public var orthography:Orthography;

	@BeforeClass
	public function suiteSetup() {
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
}
