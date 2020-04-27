package dropecho.langgen;

import seedyrng.Random;
import dropecho.langgen.Language.LanguageOrthography;

@:expose("Spell")
class Spell {
	public var ortho:LanguageOrthography;

	public function new(?ortho:LanguageOrthography) {
		var random = new Random();
		if (ortho == null) {
			this.ortho = {
				consonants: Consts.getRandomCorthSet(random),
				vowels: Consts.getRandomVorthSet(random)
			}
		} else {
			this.ortho = ortho;
		}
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
