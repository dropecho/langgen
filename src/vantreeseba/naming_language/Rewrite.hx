package vantreeseba.naming_language;

import vantreeseba.naming_language.Language.LanguageConfig;

class Rewrite {
	public var rules:Map<EReg, String> = new Map<EReg, String>();
	public var config:LanguageConfig;

	public function new(config:LanguageConfig) {
		this.config = config;
	}

	public function parseRule(char:String, rule:String) {
		var consts = config.consonants.join("");
		var vowels = config.vowels.join("");

		rule = ~/C/g.replace(rule, '[$consts]{1}');
		rule = ~/V/g.replace(rule, '[$vowels]{1}');
		rule = ~/_/g.replace(rule, '([$char]{1})');

		return rule;
	}

	public function addRule(char:String, rule:String, replaceWith:String) {
    var reg = new EReg(parseRule(char, rule), '');
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
