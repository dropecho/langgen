/// [Language]
class Language {
	new(config:?LanguageConfig)
	{}
}

/// [Language]
/// [Language.createWord]
public function createWord(?key:String, ?min:Int = 2, ?max:Int = 4):String {}

/// [Language.createWord]
/// [translate]
// outputs something like 'bareq'
var cityWord = language.createWord('city');

// outputs something like 'yilm'
var purpleWord = language.createWord('purple');

// outputs something like 'bareq yilm'
var phrase = language.createPhrase('myCity');

// outputs [city=>'', purple=>'']
var translated = language.translate(phrase);

/// [translate]
/// [LanguageConfig]
typedef LanguageConfig = {
	// Phonemes
	var consonants:Array<String>;
	var vowels:Array<String>;

	// Structures
	var syllable_structure:String;
	var phrase_structure:String;
}

/// [LanguageConfig]
