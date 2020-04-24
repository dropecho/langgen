package vantreeseba.naming_language;

import vantreeseba.naming_language.Language.LanguageOrthography;

class Spell {
	public var ortho:LanguageOrthography;

	public function new(ortho:LanguageOrthography) {
		this.ortho = ortho;
	}

	public function getOrthoChar(char:String):String {
		if (ortho.consonants != null && ortho.consonants.exists(char)) {
			return ortho.consonants.get(char);
		}
		if (ortho.vowels != null && ortho.vowels.exists(char)) {
			return ortho.vowels.get(char);
		}

		if (Consts.default_ortho.exists(char)) {
			return Consts.default_ortho.get(char);
		}

		return char;
	}

	public function spell(s:String):String {
		return [for (char in s.split("")) getOrthoChar(char)].join("");
	}
}
