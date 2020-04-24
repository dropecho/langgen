import massive.munit.TestSuite;

import naming_language.ConstsTest;
import naming_language.LanguageTest;
import naming_language.RewriteTest;
import naming_language.SpellTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite extends massive.munit.TestSuite
{
	public function new()
	{
		super();

		add(naming_language.ConstsTest);
		add(naming_language.LanguageTest);
		add(naming_language.RewriteTest);
		add(naming_language.SpellTest);
	}
}
