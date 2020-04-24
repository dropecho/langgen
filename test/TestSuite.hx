import massive.munit.TestSuite;

import langgen.ConstsTest;
import langgen.LanguageTest;
import langgen.RewriteTest;
import langgen.SpellTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite extends massive.munit.TestSuite
{
	public function new()
	{
		super();

		add(langgen.ConstsTest);
		add(langgen.LanguageTest);
		add(langgen.RewriteTest);
		add(langgen.SpellTest);
	}
}
