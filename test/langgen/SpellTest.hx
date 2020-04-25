package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class SpellTest {
	public var speller:Spell;

	@BeforeClass
	public function suiteSetup() {
		var ortho = {
			consonants: Consts.corthsets['Default'],
			vowels: Consts.vorthsets['Default'],
		};
		speller = new Spell(ortho);
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(speller);
	}

	@Test
	public function testOrthos() {
		var cControl = 'd';
		var cTest = "ʃ".split("")[0];
		var vTest = "A";
		var vControl = "a";

		Assert.areEqual(cControl, speller.getOrthoChar(cControl));
		Assert.areEqual('sh', speller.getOrthoChar(cTest));
		Assert.areEqual(vControl, speller.getOrthoChar(vControl));
		Assert.areEqual('á', speller.getOrthoChar(vTest));
	}

  @Test
  public function testSpelling() {
		var before = "aʃ";
    var after = speller.spell(before);
    var expected = "ash";

    Assert.areEqual(expected, after);
  }
}
