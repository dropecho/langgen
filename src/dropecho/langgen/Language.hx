package dropecho.langgen;

import haxe.ds.StringMap;
import seedyrng.Random;
import dropecho.langgen.Consts;
import dropecho.langgen.Spell;
import dropecho.langgen.Rewrite;

using StringTools;

@:expose("Config")
typedef LanguageConfig = {
	// Phonemes
	var consonants:Array<String>;
	var vowels:Array<String>;
	var liquids:Array<String>;
	var sibilants:Array<String>;
	var finals:Array<String>;
	var rewriteset:Array<Dynamic>;

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
	public var rewrite:Rewrite;

	public var config:LanguageConfig;

	public var words:StringMap<String> = new StringMap<String>();
	public var trans_words:StringMap<String> = new StringMap<String>();

	public var genitive:String;
	public var definite:String;

	public function new(?config:LanguageConfig, ?seed:String) {
		this.random = new Random();
		if (seed != null) {
			this.random.setStringSeed(seed);
		}
		var randommin:Int;

		this.config = config != null ? config : {
			consonants: Consts.getRandomConsonantSet(random),
			vowels: Consts.getRandomVowelSet(random),
			syllable_structure: Consts.getRandomSyllableStructure(random),
			phrase_structure: Consts.getRandomPhraseStructure(random),
			sibilants: Consts.getRandomSibilantSet(random),
			liquids: Consts.getRandomLiquidSet(random),
			finals: Consts.getRandomFinalSet(random),
			rewriteset: Consts.getRandomRewriteSet(random),
			word_length_min: randommin = random.randomInt(1, 2),
			word_length_max: random.randomInt(randommin + 1, randommin + random.randomInt(1, 4))
		};

		spell = new Spell(null, seed);
		rewrite = new Rewrite(this.config);

		// TODO: Extract this to something else.
		genitive = createWord("of", 1, 1);
		definite = createWord("the", 1, 1);
	}

	public function createSyllable():String {
		var split = config.syllable_structure.split("");
		return [
			for (x in 0...split.length) {
				if (split[x] == "?")
					continue;

				if (x < split.length - 1 && split[x + 1] == "?" && random.random() > 0.5)
					continue;

				switch (split[x]) {
					case "C":
						random.choice(config.consonants);
					case "V":
						random.choice(config.vowels);
					case "S":
						random.choice(config.sibilants);
					case "L":
						random.choice(config.liquids);
					case "F":
						random.choice(config.finals);
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

		var word = [for (_ in 0...random.randomInt(min, max)) createSyllable()].join("");

		word = spell.spell(rewrite.rewrite(word));

		if (key != null && !words.exists(key)) {
			words.set(key, word);
			trans_words.set(word, key);
		}

		return word;
	}

	public function createPhrase(?key:String):String {
		var subject = null;
		if (key != null && words.exists(key)) {
			subject = words.get(key);
		} else {
			subject = createWord();
		}
		var split = config.phrase_structure.split("");
		var phrase = [
			for (x in 0...split.length) {
				if (split[x] == "?")
					continue;

				if (x < split.length - 1 && split[x + 1] == "?" && random.random() > 0.5)
					continue;

				switch (split[x]) {
					case "D":
						definite;
					case "G":
						genitive;
					case "N":
						var choices = [for (k in words.keys()) k].filter(x -> x != "the" && x != "of");
						// if (this.random.random() > 0.2 && choices.length > 0) {
						if (choices.length > 0) {
							words.get(random.choice(choices));
						} else {
							createWord();
						}
					case "S":
						subject;
					case _:
						"";
				}
			}
		].join(" ");

		return phrase;
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
