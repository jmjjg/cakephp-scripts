```bash
# Put this in your ~/.bashrc_cake3 then the next 2 lines uncommented in your .bashrc
# eval HOME="~"
# . "${HOME}/.bashrc_cake3"

# Check for a CakePHP 3.x install
function cake3_check() {
	echo "Checking for a CakePHP 3.x install" && \
		grep "^3\.[0-9]\+" vendor/cakephp/cakephp/VERSION.txt

	return $?
}

# Clears quality folder and lof files in tmp for a CakePHP 3.x install
function cake3_clear() {
	cake3_check && \
		echo "Clearing the CakePHP 3 install" && \
		# @todo filter by user/group (www-data|jenkins)
		sudo bash -c "( \
			sudo bin/cake orm_cache clear && \
			rm -f logs/*.log && \
			rm -rf logs/quality && \
			find tmp -type f ! -name 'empty' -exec rm {} \; )"

	return $?
}

# Jenkins code build for a CakePHP 3.x plugin
function cake3_plugin_build() {
	name="$1"

	cake3_clear && \
		echo "Building the CakePHP 3 plugin ${name}" && \
		sudo -u jenkins ant build -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}

# Jenkins code quality for a CakePHP 3.x plugin
function cake3_plugin_quality() {
	name="$1"

	cake3_clear && \
		echo "Quality for the CakePHP 3 plugin ${name}" && \
		sudo -u jenkins ant quality -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}

# PHPUnit for a CakePHP 3.x plugin
function cake3_plugin_phpunit() {
	name="$1"

	cake3_check && \
		echo "Unit tests for the CakePHP 3 plugin ${name}" && \
		sudo -u jenkins ant phpunit_only -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}
```