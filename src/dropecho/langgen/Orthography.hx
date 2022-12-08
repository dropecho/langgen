package dropecho.langgen;

import seedyrng.Random;
import dropecho.langgen.Language.Graphemes;

@:expose("Orthography")
class Orthography {
	public var ortho:Graphemes;

	public function new(?ortho:Graphemes, ?seed:String) {
		var random = new Random();
		if (seed != null) {
			random.setStringSeed(seed);
		}
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
