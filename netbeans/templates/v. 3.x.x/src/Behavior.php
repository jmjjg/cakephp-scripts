<#include "../freemarker_functions.ftl">
<?php
/**
 * Source code for the ${namespace}\Model\Behavior\${name} class.
 *
 * @author ${author}
 * @license ${license}
 */
namespace ${namespace}\Model\Behavior;

use Cake\Event\Event;
use Cake\ORM\Behavior;
use Cake\ORM\RulesChecker;
use Cake\Validation\Validator;

/**
 * ${name} Behavior.
 */
class ${name} extends Behavior
{
    /**
     * Default configuration.
     *
     * @var array
     */
    protected $_defaultConfig = [];

    /**
	 * ...
	 *
     * @param \Cake\Event\Event $event The calling event
     * @param \Cake\Validation\Validator $validator The validator object
     * @param string $name The name of the validator oject
     * @return void
     */
    public function buildValidator(Event $event, Validator $validator, $name)
    {
    }

    /**
     * ...
     *
     * @param \Cake\Event\Event $event The calling event
     * @param \Cake\ORM\RulesChecker $rules The rules object to be modified.
     * @return \Cake\ORM\RulesChecker
     */
    public function buildRules(Event $event, RulesChecker $rules)
    {
        return $rules;
    }
}