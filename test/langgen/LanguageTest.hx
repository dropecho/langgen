package langgen;

import dropecho.langgen.*;
import massive.munit.Assert;

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
	public function seededLanguageIsDeterministic() {
		var lang1 = new Language(null, "42");
		var lang2 = new Language(null, "42");

		Assert.areEqual(lang1.createWord(), lang2.createWord());
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

		Assert.isTrue(phrase.indexOf(word) >= 0);
	}

	@Test
	public function translateKnownWordReturnsKey() {
		var word = language.createWord("city");
		var translated = language.translate(word);

		Assert.areEqual("city", translated.get(word));
	}

	@Test
	public function translateUnknownWordReturnsUnknown() {
		var translated = language.translate("zzznomatch");

		Assert.areEqual("UNKNOWN", translated.get("zzznomatch"));
	}

	@Test
	public function createPhraseWithKeyAgainAndTranslate() {
		var word = language.createWord("city");
		var phrase = language.createPhrase("city");

		var translated = language.translate(phrase);

		Assert.isNotNull(translated);
	}
}
