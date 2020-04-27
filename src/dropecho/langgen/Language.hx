package dropecho.langgen;

import haxe.ds.StringMap;
import seedyrng.Random;
import dropecho.langgen.Consts;
import dropecho.langgen.Spell;

@:expose("Config")
typedef LanguageConfig = {
	// Phonemes
	var consonants:Array<String>;
	var vowels:Array<String>;

	// Structures
	var syllable_structure:String;
	var phrase_structure:String;
}

// "Spelling, i.e. the written script".
typedef LanguageOrthography = {
	var consonants:Map<String, String>;
	var vowels:Map<String, String>;
}

@:expose("Language")
class Language {
	public var random:Random;
	public var spell:Spell;

	public var config:LanguageConfig;

	public var words:StringMap<String> = new StringMap<String>();
	public var trans_words:StringMap<String> = new StringMap<String>();

	public var genitive:String;
	public var definite:String;

	public function new(?config:LanguageConfig) {
		this.random = new Random();

		this.config = config != null ? config : {
			consonants: Consts.getRandomConsonantSet(random),
			vowels: Consts.getRandomVowelSet(random),
			syllable_structure: Consts.getRandomSyllableStructure(random),
			phrase_structure: Consts.getRandomPhraseStructure(random)
		};

		spell = new Spell();

		// TODO: Extract this to something else.
		genitive = createWord("of", 1, 1);
		definite = createWord("the", 1, 1);
	}

	public function createSyllable():String {
		return [
			for (x in config.syllable_structure.split("")) {
				if (x.split("")[0] == "?") {
					if (this.random.random() > 0.5)
						continue;
				}
				switch (x) {
					case "C" | "?C":
						random.choice(config.consonants);
					case "V" | "?V":
						random.choice(config.vowels);
					case _:
						"";
				}
			}
		].join("");
	}

	public function createWord(?key:String, ?min:Int = 2, ?max:Int = 4):String {
		if (key != null && words.exists(key)) {
			return words.get(key);
		}

		var word = [
			for (_ in 0...random.randomInt(min, max))
				this.createSyllable()
		].join("");

    word = spell.spell(word);

		if (key != null && !words.exists(key)) {
			words.set(key, word);
			trans_words.set(word, key);
		}

		return word; //spell.spell(word);
	}

	public function createPhrase(?key:String):String {
		var subject = null;
		if (key != null && words.exists(key)) {
			subject = words.get(key);
		}
		var phrase = [
			for (x in config.phrase_structure.split("")) {
				if (x.split("")[0] == "?" && this.random.random() > 0.5)
					continue;
				switch (x) {
					case "D" | "?D":
						definite;
					case "G" | "?G":
						genitive;
					case "N" | "?N":
						createWord();
					case "S":
						subject != null ? subject : createWord(key);
					case _:
						"";
				}
			}
		].join(" ");

		return spell.spell(phrase);
	}

	public function translate(text:String) {
		var tokens = text.split(" ");

		return [
			for (x in tokens) {
				var word = trans_words.exists(x) ? trans_words.get(x) : 'UNKNOWN';
				x => word;
			}
		];
	}
}
