## Language

This is a language generator, it can create words and phrases/titles based on
config.

<!-- panels:start -->
<!-- div:title-panel -->

### Language(config:?[LanguageConfig][], seed:?string)

<!-- div:left-panel -->

| parameter | type           | default            | description                                                         |
| --------- | -------------- | ------------------ | ------------------------------------------------------------------- |
| config    | LanguageConfig | [LanguageConfig][] | The configuration used to generate the language                     |
| seed      | String         |                    | The seed used to generate the language (can be used to regenerate.) |

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->

### Language.createSyllable() => String

<!-- div:left-panel -->

Creates a syllable from the language.

| parameter | type | default | description |
| --------- | ---- | ------- | ----------- |

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->

### Language.createWord(key,min,max) => String

<!-- div:left-panel -->

| parameter | type   | default | description                                 |
| --------- | ------ | ------- | ------------------------------------------- |
| key       | string |         | key to store word as (usually english word) |
| min       | int    | 2       | the minimum number of syllables for a word. |
| max       | int    | 4       | the maximum number of syllables for a word. |

stores the word in "cache" to be used as subjects or nouns

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->

### Language.createPhrase(key) => String

<!-- div:left-panel -->

| parameter | type   | default | description                              |
| --------- | ------ | ------- | ---------------------------------------- |
| key       | string |         | The key to store the generated phrase as |

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->

### Language.translate(text) => Map<String, String>

<!-- div:left-panel -->

| parameter | type   | default | description                                                 |
| --------- | ------ | ------- | ----------------------------------------------------------- |
| text      | string |         | a "sentence or phrase" to change from language back to keys |

<!-- div:right-panel -->

<!-- tabs:start -->

#### **Haxe**

[](_api/api.hx ':include :type=code :fragment=translate')

#### **JS**

[](_api/api.hx ':include :type=code :fragment=translate')

<!-- tabs:end -->

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->

## LanguageConfig

<!-- div:left-panel -->
<!-- for consonants and vowels see [Consts.hx](src/dropecho/langgen/Consts.hx) -->

| member             | type          | description                                   |
| ------------------ | ------------- | --------------------------------------------- |
| consonants         | Array<String> | A list of the consonants for the language     |
| vowels             | Array<String> | A list of vowels for the language             |
| syllable_structure | String        | see [syllable_structure](#syllable_structure) |
| phrase_structure   | String        | see [phrase_structure](#phrase_structure)     |

##### syllable_structure - a string representing the syllable

The options are C, V, and ?, where ? makes the previous optional.

- "CVC" a syllable must have a consonant, vowel, consonant.
- "CVV?C" a syllable must have a consonant, vowel, optional vowel, consonant.

##### phrase_structure - a string representing phrases/titles

- "DS" => definite subject (i.e. the city).
- "DSGN" => definite subject genitive noun (i.e. the city of stone)

<!-- div:right-panel -->
<!-- tabs:start -->

#### **Haxe**

[](_api/api.hx ':include :type=code :fragment=LanguageConfig')

#### **JS**

[](_api/api.js ':include :type=code :fragment=LanguageConfig')

<!-- tabs:end -->
<!-- panels:end -->

[languageconfig]: #LanguageConfig
[language.hx]: https://github.com/dropecho/langgen/blob/master/src/dropecho/langgen/Language.hx
