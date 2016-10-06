<#include "../freemarker_functions.ftl">
<?php
/**
 * Source code for the ${namespace}\Test\TestCase\Model\Table\${name} class.
 *
 * @author ${author}
 * @license ${license}
 */
namespace ${namespace}\Test\TestCase\Model\Table;

use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * The class ${namespace}\Test\TestCase\Model\Table\${name} tests the
 * ${namespace}\Model\Table\${original_classname(name)}Table class.
 *
 * @property ${namespace}\Model\Table\${original_classname(name)}Table $${original_classname(name)}
 */
class ${name} extends TestCase
{
    /**
     * fixtures
     *
     * @var array
     */
	public $fixtures = ['${underscore(namespace)}.${original_classname(name)}'];

    /**
     * setUp() method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $this->${original_classname(name)} = TableRegistry::get('${original_classname(name)}');
    }

    /**
     * tearDown() method
     *
     * @return void
     */
    public function tearDown()
    {
        parent::tearDown();
    }

    /**
     * Test the ${namespace}\Model\Table\${original_classname(name)}Table::method.
	 *
     * @return void
	 * @covers ${namespace}\Model\Table\${original_classname(name)}Table::method.
     */
    public function testMethod()
    {
		$this->markTestIncomplete();

        $result = $this->${original_classname(name)}->method();
        $expected = null;

        $this->assertEquals($expected, $result, var_export($result, true));
    }
}