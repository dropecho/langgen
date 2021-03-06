package dropecho.langgen;

import dropecho.langgen.Language.LanguageConfig;

class Rewrite {
	public var rules:Map<EReg, String> = new Map<EReg, String>();
	public var config:LanguageConfig;

	public function new(config:LanguageConfig) {
		this.config = config;

		for (rule in this.config.rewriteset) {
			addRule(rule.character, rule.rule, rule.replaceWith);
		}
	}

	public function parseRule(char:String, rule:String) {
		var consts = config.consonants.join("");
		var vowels = config.vowels.join("");

		rule = ~/C/g.replace(rule, '[$consts]{1}');
		rule = ~/V/g.replace(rule, '[$vowels]{1}');
		rule = ~/_/g.replace(rule, '($char)');

		return rule;
	}

	public function addRule(char:String, rule:String, replaceWith:String) {
		var reg = new EReg(parseRule(char, rule), 'g');
		rules.set(reg, replaceWith);
	}

	public function rewrite(s:String) {
		var after = s;
		for (rule => replaceWith in rules) {
			after = rule.replace(after, replaceWith);
		}
		return after;
	}
}
