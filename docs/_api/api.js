/// [Language.createWord]
language.createWord(key, min = 2, max = 4){}
/// [Language.createWord]

/// [LanguageConfig]
/** class */
var config = {
  // Phonemes
  /** @member{Array<String>} */
  consonants: [],
  /** @member{Array<String>} */
  vowels: [],

  // Structures
  /** @member {String} */
  syllable_structure: '',
  /** @member {String} */
  phrase_structure: '',
};

var language = new Language(config);
/// [LanguageConfig]
