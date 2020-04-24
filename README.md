# Naming language generator

This is code for generating a 'naming language', using the algorithm behind [@unchartedatlas][uncharted]. For more details, see [these notes][notes].

[uncharted]: https://twitter.com/unchartedatlas
[notes]: http://mewo2.com/notes/naming-language/

[Example Codepen](https://codepen.io/vantreeseba/pen/pZKrwp)

### Language

This is a language generator, it can create words and phrases/titles based on
config.

CONFIG:
``` haxe
typedef LanguageConfig = {
	// Phonemes
	var consonants:Array<String>;
	var vowels:Array<String>;

	// Structures
	var syllable_structure:String;
	var phrase_structure:String;
}

```

syllable_structure is a string representing the syllable so
"CVC" means a syllable must have a consonant vowel consonant.
"CVV?C" means a syllable must have a consonant vowel optional vowel consonant. 

phrase_structure is a string representing phrases/titles

"DS" => definite subject (i.e. the city).
"DSGN" => definite subject genitive noun (i.e. the city of stone)

new Language(config:LanguageConfig)

Language.createWord
```
public function createWord(?key:String, ?min:Int = 2, ?max:Int = 4):String {}
```

- creates a word based on the key
- min syllables
- max syllables

stores the word in "cache" to be used as subjects or nouns

## JS

```javascript

const { Language, Consts, Spell } = require('@dropecho/langgen');

var lang = new Language();

console.log(lang.createWord("city"));
console.log(lang.createPhrase("city"));

// outputs something like 'mimak'
// outputs something like 'mimak var'

```

## Haxe

```haxe
import dropecho.langgen.Language;

class Main {
  static public function main():Void {
    var lang = new Language();

    console.log(lang.createWord("city"));
    console.log(lang.createPhrase("city"));

    // outputs something like 'mimak'
    // outputs something like 'mimak var'
  }
}

```
