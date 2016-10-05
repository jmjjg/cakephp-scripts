<#include "../freemarker_functions.ftl">
<?php
/**
 * Source code for the ${namespace}\Model\Table\${name} class.
 *
 * @author ${author}
 * @license ${license}
 */
namespace ${namespace}\Model\Table;

use Cake\ORM\Table;

/**
 * ${name} Model.
 *
 * @property \Cake\ORM\Association\BelongsTo $WWW
 * @property \Cake\ORM\Association\BelongsToMany $XXX
 * @property \Cake\ORM\Association\HasMany $YYY
 * @property \Cake\ORM\Association\HasOne $ZZZ
 */
class ${name} extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        parent::initialize($config);

        $this->table('${table(name)}');
        $this->displayField('name');
        $this->primaryKey('id');

        $this->addBehavior('Timestamp');

        // $this->belongsTo('WWW', ['foreignKey' => '_id']);
        // $this->belongsToMany('XXX', ['foreignKey' => '_id', 'targetForeignKey' => null, 'joinTable' => null, 'through' => null]);
		// $this->hasMany('YYY', ['foreignKey' => '_id']);
		// $this->hasOne('ZZZ', ['foreignKey' => '_id']);
	}
}