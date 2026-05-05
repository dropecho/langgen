package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;
import seedyrng.Random;

class ConstsTest {
	var random:Random;

	@Before
	public function setup() {
		random = new Random();
	}

	@Test
	public function canGetSet() {
		var foo = Consts.consonant_sets["Minimal"];

		Assert.isNotNull(foo);
	}

	@Test
	public function randomConsonants() {
		var foo = Consts.getRandomConsonantSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomVowels() {
		var foo = Consts.getRandomVowelSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomSibilants() {
		var foo = Consts.getRandomSibilantSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomLiquids() {
		var foo = Consts.getRandomLiquidSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomFinals() {
		var foo = Consts.getRandomFinalSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomRewriteSet() {
		var foo = Consts.getRandomRewriteSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomSyllableStructure() {
		var foo = Consts.getRandomSyllableStructure(random);

		Assert.isNotNull(foo);
		Assert.isTrue(foo.length > 0);
	}

	@Test
	public function randomPhraseStructure() {
		var foo = Consts.getRandomPhraseStructure(random);

		Assert.isNotNull(foo);
		Assert.isTrue(foo.length > 0);
	}

	@Test
	public function randomCorthSet() {
		var foo = Consts.getRandomCorthSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomVorthSet() {
		var foo = Consts.getRandomVorthSet(random);

		Assert.isNotNull(foo);
	}
}
