import massive.munit.TestSuite;

import src.controller.GameControllerTest;
import src.controller.MainControllerTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(src.controller.GameControllerTest);
		add(src.controller.MainControllerTest);
	}
}
