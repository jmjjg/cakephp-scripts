<#include "../freemarker_functions.ftl">
<?php
/**
 * Source code for the ${namespace}\Test\Fixture\${name} class.
 *
 * @author ${author}
 * @license ${license}
 */
namespace ${namespace}\Test\Fixture;

use Cake\Datasource\ConnectionInterface;
use Cake\TestSuite\Fixture\TestFixture;

/**
 * The ${name} class will create the ${underscore(original_classname(name))} table.
 */
class ${name} extends TestFixture
{

    /**
     * {@inheritDoc}
     */
    public $import = ['model' => '${original_classname(name)}'];

    /**
     * {@inheritDoc}
     */
    public $records = [];


    /**
     * {@inheritDoc}
     */
    public function create(ConnectionInterface $db)
    {
        $result = parent::create($db);
        return $result;
    }

    /**
     * {@inheritDoc}
     */
    public function drop(ConnectionInterface $db)
    {
        $result = parent::drop($db);
        return $result;
    }


    /**
     * {@inheritDoc}
     */
    public function createConstraints(ConnectionInterface $db)
    {
        $result = parent::createConstraints($db);
        return $result;
    }

    /**
     * {@inheritDoc}
     */
    public function dropConstraints(ConnectionInterface $db)
    {
        $result = parent::dropConstraints($db);
        return $result;
    }
}
