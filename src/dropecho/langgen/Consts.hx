package dropecho.langgen;

import seedyrng.Random;

@:expose("Consts")
class Consts {
	public static var consonant_sets = [
		'Minimal' => 'ptkmnls'.split(""),
		'English-ish' => 'ptkbdgmnlrsʃzʒʧ'.split(""),
		'Pirahã (very simple)' => 'ptkmnh'.split(""),
		'Hawaiian-ish' => 'hklmnpwʔ'.split(""),
		'Greenlandic-ish' => 'ptkqvsgrmnŋlj'.split(""),
		'Arabic-ish' => 'tksʃdbqɣxmnlrwj'.split(""),
		'Arabic-lite' => 'tkdgmnsʃ'.split(""),
		'English-lite' => 'ptkbdgmnszʒʧhjw'.split("")
	];

	public static var vowel_sets = [
		'Default' => 'aeiou'.split(""),
		'3-vowel a i u' => 'aiu'.split(""),
		'Extra A E I' => 'aeiouAEI'.split(""),
		'Extra U' => 'aeiouU'.split(""),
		'5-vowel a i u A I' => 'aiuAI'.split(""),
		'3-vowel e o u' => 'eou'.split(""),
		'Extra A O U' => 'aeiouAOU'.split("")
	];

	static public var sibilant_sets = ['Just s' => ['s'], 's ʃ' => ['s', 'ʃ'], 's ʃ f' => ['s', 'ʃ', 'f']];

	static public var liquid_sets = [
		'r l' => 'rl'.split(""),
		'Just r' => 'r'.split(""),
		'Just l' => 'l'.split(""),
		'w j' => 'wj'.split(""),
		'r l w j' => 'rlwj'.split("")
	];

	static public var final_sets = [
		'm n' => 'mn'.split(""),
		's k' => 'sk'.split(""),
		'm n ŋ' => 'mnŋ'.split(""),
		's ʃ z ʒ' => 'sʃzʒ'.split("")
	];

	/*
	 * C = consonant
	 * V = vowel
	 * L = liquid
	 * F = final
	 * S = sibilant
	 */
	public static var syllable_structures:Array<String> = [
		'CVC', 'CVV?C', 'CVVC?', 'CVC?', 'CV', 'VC', 'CVF', 'C?VC', 'CVF?', 'CL?VC', 'CL?VF', 'S?CVC', 'S?CVF', 'S?CVC?', 'C?VF', 'C?VC?', 'C?VF?', 'C?L?VC',
		'VC', 'CVL?C?', 'C?VL?C', 'C?VLC?'
	];

	/*
	 * S = Subject key if given in create phrase
	 		* N = Noun
	 		* D = Definite
	 		* G = Genitive
	 		* ? = Make word before optional
	 */
	// public static var phrase_structures:Array<String> = [
	//   'NS', 'DS', 'DSGN', 'DNGN', 'NGN', 'D?N', 'N?N', 'D?NN?', 'DNN?', 'D?NG?N', 'D?NNG?', 'D?NNG', 'D?NG?N?', 'D?G?NN',
	// ];
	public static var phrase_structures:Array<String> = [
		'DS', 'DSGN', 'DNGN', 'NGS', 'D?S', 'S?N', 'D?SN?', 'DSN?', 'D?SG?N', 'D?NSG?', 'D?NSG', 'D?SG?N?', 'D?G?NS'
	];

	static public var default_ortho = [
		'ʃ' => 'sh', 'ʒ' => 'zh', 'ʧ' => 'ch', 'ʤ' => 'j', 'ŋ' => 'ng', 'j' => 'y', 'x' => 'kh', 'ɣ' => 'gh', 'ʔ' => '‘', 'A' => 'á', 'E' => 'é', 'I' => 'í',
		'O' => 'ó', 'U' => 'ú'
	];

	static public var corthsets = [
		'Default' => new Map<String, String>(),
		'Slavic' => ['ʃ' => 'š', 'ʒ' => 'ž', 'ʧ' => 'č', 'ʤ' => 'ǧ', 'j' => 'j'],
		'German' => ['ʃ' => 'sch', 'ʒ' => 'zh', 'ʧ' => 'tsch', 'ʤ' => 'dz', 'j' => 'j', 'x' => 'ch'],
		'French' => ['ʃ' => 'ch', 'ʒ' => 'j', 'ʧ' => 'tch', 'ʤ' => 'dj', 'x' => 'kh'],
		'Chinese (pinyin)' => ['ʃ' => 'x', 'ʧ' => 'q', 'ʤ' => 'j',]
	];

	static public var vorthsets = [
		'Ácutes' => new Map<String, String>(),
		'Ümlauts' => ['A' => 'ä', 'E' => 'ë', 'I' => 'ï', 'O' => 'ö', 'U' => 'ü'],
		'Welsh' => ['A' => 'â', 'E' => 'ê', 'I' => 'y', 'O' => 'ô', 'U' => 'w'],
		'Diphthongs' => ['A' => 'au', 'E' => 'ei', 'I' => 'ie', 'O' => 'ou', 'U' => 'oo'],
		'Doubles' => ['A' => 'aa', 'E' => 'ee', 'I' => 'ii', 'O' => 'oo', 'U' => 'uu']
	];

	static public var rewritesets = [
		'None' => [],
		'No double sounds' => [{character: "", rule: "(.)\\1", replaceWith: "$1"}],
		'No vowels at end' => [{character: "", rule: "V$", replaceWith: ""}],
		'No u followed by vowels' => [{character: "u", rule: "_V", replaceWith: ""}],
	];

	public static function getRandomCorthSet(random:Random) {
		return corthsets.get(random.choice([for (k in corthsets.keys()) k]));
	}

	public static function getRandomVorthSet(random:Random) {
		return vorthsets.get(random.choice([for (k in vorthsets.keys()) k]));
	}

	public static function getRandomConsonantSet(random:Random) {
		var keys = [for (x in consonant_sets.keys()) x];
		return consonant_sets[random.choice(keys)];
	}

	public static function getRandomVowelSet(random:Random) {
		var keys = [for (x in vowel_sets.keys()) x];
		return vowel_sets[random.choice(keys)];
	}

	public static function getRandomSibilantSet(random:Random) {
		var keys = [for (x in sibilant_sets.keys()) x];
		return sibilant_sets[random.choice(keys)];
	}

	public static function getRandomFinalSet(random:Random) {
		var keys = [for (x in final_sets.keys()) x];
		return final_sets[random.choice(keys)];
	}

	public static function getRandomLiquidSet(random:Random) {
		var keys = [for (x in liquid_sets.keys()) x];
		return liquid_sets[random.choice(keys)];
	}

	public static function getRandomRewriteSet(random:Random) {
		var keys = [for (x in rewritesets.keys()) x];
		return rewritesets[random.choice(keys)];
	}

	public static function getRandomSyllableStructure(random:Random) {
		return random.choice(syllable_structures);
	}

	public static function getRandomPhraseStructure(random:Random) {
		return random.choice(phrase_structures);
	}
}
/*

	const ressets = [
	  {
	name: 'None',
	res: []
	  },
	  {
	name: 'Double sounds',
	res: [/(.)\1/]
	  },
	  {
	name: 'Doubles and hard clusters',
	res: [/[sʃf][sʃ]/, /(.)\1/, /[rl][rl]/]
	  }
	];

	module.exports = {
	  defaultOrtho,
	  corthsets,
	  vorthsets,
	  consets,
	  ssets,
	  lsets,
	  fsets,
	  vowsets,
	  syllstructs,
	  ressets,
	  phrasestructs
	};

 */
