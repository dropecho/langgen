package langgen;

import massive.munit.Assert;
import dropecho.langgen.*;

class LanguageTest {
	public var language:Language;

	@BeforeClass
	public function suiteSetup() {}

	@Before
	public function setup() {
		language = new Language();
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(language);
	}

	@Test
	public function createSyllable() {
		var syl = language.createSyllable();
		Assert.isNotNull(syl);
	}

	@Test
	public function createWord() {
		var syl = language.createWord();
		Assert.isNotNull(syl);
	}

	@Test
	public function createWordTwiceShouldGiveSameWord() {
		var word = language.createWord("city");
		var word2 = language.createWord("city");

		Assert.areEqual(word, word2);
	}

	@Test
	public function createPhrase() {
		var phrase = language.createPhrase();

		Assert.isNotNull(phrase);
	}

	@Test
	public function createPhraseWithKey() {
		var word = language.createWord("city");
		var phrase = language.createPhrase("city");

		Assert.isNotNull(phrase);
	}

	@Test
	public function createPhraseWithKeyAgain() {
		var word = language.createWord("city");
		var phrase = language.createPhrase("city");

		Assert.isNotNull(phrase);
	}

	@Test
	public function createPhraseWithKeyAgainAndTranslate() {
		var word = language.createWord("city");
		var phrase = language.createPhrase("city");

		var translated = language.translate(phrase);

		Assert.isNotNull(translated);
	}
}
