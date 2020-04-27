package dropecho.langgen;

import haxe.ds.StringMap;
import seedyrng.Random;
import dropecho.langgen.Consts;
import dropecho.langgen.Spell;

using StringTools;

@:expose("Config")
typedef LanguageConfig = {
	// Phonemes
	var consonants:Array<String>;
	var vowels:Array<String>;
	var lset:Array<String>;
	var sset:Array<String>;
	var fset:Array<String>;

	// Structures
	var syllable_structure:String;
	var phrase_structure:String;
	var word_length_min:Int;
	var word_length_max:Int;
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
		var randommin:Int;

		this.config = config != null ? config : {
			consonants: Consts.getRandomConsonantSet(random),
			vowels: Consts.getRandomVowelSet(random),
			syllable_structure: Consts.getRandomSyllableStructure(random),
			phrase_structure: Consts.getRandomPhraseStructure(random),
			sset: Consts.getRandomSSet(random),
			lset: Consts.getRandomLSet(random),
			fset: Consts.getRandomFSet(random),
			word_length_min: randommin = random.randomInt(1, 3),
			word_length_max: random.randomInt(randommin + 1, randommin + random.randomInt(0, 5))
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
					case "S" | "?S":
						random.choice(config.sset);
					case "L" | "?L":
						random.choice(config.lset);
					case "F" | "?F":
						random.choice(config.fset);
					case _:
						"";
				}
			}
		].join("");
	}

	public function createWord(?key:String, ?min:Int, ?max:Int):String {
		if (min == null) {
			min = config.word_length_min;
		}
		if (max == null) {
			max = config.word_length_max;
		}

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

		return word; // spell.spell(word);
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
						if (this.random.random() > 0.2) {
							words.get(random.choice([for (k in words.keys()) k].filter(x -> x != "the" && x != "of")));
						} else {
							createWord();
						}
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
		var tokens = text.trim().split(" ");

		return [
			for (x in tokens.filter(x -> x != null && x.length > 0)) {
				var word = trans_words.exists(x) ? trans_words.get(x) : 'UNKNOWN';
				x => word;
			}
		];
	}
}
