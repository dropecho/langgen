package naming_language;

import massive.munit.Assert;
import vantreeseba.naming_language.*;
import seedyrng.Random;

class ConstsTest {
	@Test
	public function canGetSet() {
		var foo = Consts.consonant_sets["Test"];

		Assert.isNotNull(foo);
	}

	@Test
	public function randomConsonants() {
		var random = new Random();
		var foo = Consts.getRandomConsonantSet(random);

		Assert.isNotNull(foo);
	}

	@Test
	public function randomVowels() {
		var random = new Random();
		var foo = Consts.getRandomVowelSet(random);

		Assert.isNotNull(foo);
	}
}
