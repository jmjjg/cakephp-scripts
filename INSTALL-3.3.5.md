# CakePHP 3.3.x

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

```bash
php composer.phar self-update
php composer.phar create-project --prefer-dist cakephp/app 3.3.5

git clone https://github.com/jmjjg/cakephp-database 3.3.5/plugins/Database
git clone https://github.com/jmjjg/cakephp-helpers 3.3.5/plugins/Helpers
git clone https://github.com/jmjjg/cakephp-postgres 3.3.5/plugins/Postgres
git clone https://github.com/jmjjg/cakephp-translator 3.3.5/plugins/Translator

cd 3.3.5
```

## composer.json

```json
{
	// ...
	"autoload": {
		"psr-4": {
			"App\\": "src",
			"Database\\": "./plugins/Database/src",
			"Helpers\\": "./plugins/Helpers/src",
			"Postgres\\": "./plugins/Postgres/src",
			"Translator\\": "./plugins/Translator/src"
		}
	},
	"autoload-dev": {
		"psr-4": {
			"App\\Test\\": "tests",
			"Cake\\Test\\": "./vendor/cakephp/cakephp/tests",
			"Database\\Test\\": "./plugins/Database/tests",
			"Helpers\\Test\\": "./plugins/Helpers/tests",
			"Postgres\\Test\\": "./plugins/Postgres/tests",
			"Translator\\Test\\": "./plugins/Translator/tests"
		}
	},
	// ...
}
```

```bash
php ../composer.phar update

php ../composer.phar require --dev \
	"phpunit/phpunit" \
	"cakephp/cakephp-codesniffer" \
	"phploc/phploc" \
	"phpmd/phpmd" \
	"sebastian/phpcpd" \
	"wimg/php-compatibility" && \
	php ../composer.phar dump-autoload && \
	mv vendor/wimg/php-compatibility/ vendor/squizlabs/php_codesniffer/CodeSniffer/Standards/PHPCompatibility && \
	vendor/bin/phpcs --config-set installed_paths vendor/squizlabs/php_codesniffer/CodeSniffer/Standards,vendor/cakephp/cakephp-codesniffer && \
	cp -r /var/www/htdocs/cakephp/scripts/jenkins/cake3_app/* . && \
	cake3_clear ; ant quality
```

## config/bootstrap.php

```php
Plugin::load('Database');
Plugin::load('Helpers');
Plugin::load('Postgres', ['bootstrap' => true]);
Plugin::load('Translator', ['bootstrap' => true]);
```

## config/app.php

```php
'driver' => 'Postgres\Database\Driver\Postgres'
```

## @todo

```bash
cake3_plugin_phpunit Database
cake3_plugin_phpunit Helpers
cake3_plugin_phpunit Postgres
cake3_plugin_quality Postgres
cake3_plugin_phpunit Translator

bin/cake bake all Groups
```