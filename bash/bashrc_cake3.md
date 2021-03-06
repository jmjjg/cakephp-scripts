```bash
#!/bin/bash
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
		echo "Clearing the CakePHP 3.x install" && \
		# @todo filter by user/group (www-data|jenkins)
		sudo bash -c "( \
			sudo bin/cake orm_cache clear && \
			rm -f logs/*.log && \
			rm -rf logs/quality && \
			find tmp -type f ! -name 'empty' -exec rm {} \; )"

	return $?
}

# Creates and tails logs for a CakePHP 3.x install

function cake3_tail() {
	local levels=( emergency alert critical error warning notice info debug )

	cake3_check && \
		echo "Preparing to tail logs..."

	# @todo filter by user/group (apache|www-data|jenkins)
	for level in "${levels[@]}" ; do
		local file="logs/${level}.log"
		sudo touch "${file}"
		sudo chown jenkins: "${file}"
	done
	tail -f logs/*.log

	return $?
}

# Build targets for a CakePHP 3.x install

# Unit tests for a CakePHP 3.x app

function cake3_app_phpunit() {
	name="$1"

	cake3_check && \
		echo "Unit tests for the CakePHP 3.x app" && \
		sudo -u jenkins ant phpunit_only -f "build.xml"

	return $?
}

# Normal build for a CakePHP 3.x app

function cake3_app_build() {
	name="$1"

	cake3_clear && \
		echo "Building the CakePHP 3.x app" && \
		sudo -u jenkins ant build -f "build.xml"

	return $?
}

# Code quality for a CakePHP 3.x app

function cake3_app_quality() {
	name="$1"

	cake3_clear && \
		echo "Quality for the CakePHP 3.x app" && \
		sudo -u jenkins ant quality -f "build.xml"

	return $?
}

# Build targets for a CakePHP 3.x plugin

# CakePHP 3.x plugin check

function cake3_plugin_check() {
	name="$1"

	cake3_check && \
		echo "Checking for the CakePHP 3.x plugin ${name} in plugins/${name}" && \
		test ! -z "${name}" && \
		test -d "plugins/${name}"

	return $?
}

# Unit tests for a CakePHP 3.x plugin

function cake3_plugin_phpunit() {
	name="$1"

	cake3_plugin_check "${name}" && \
		echo "Unit tests for the CakePHP 3.x plugin ${name}" && \
		sudo -u jenkins ant phpunit_only -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}

# Normal build for a CakePHP 3.x plugin

function cake3_plugin_build() {
	name="$1"

	cake3_plugin_check "${name}" && \
		cake3_clear &>/dev/null && \
		echo "Building the CakePHP 3.x plugin ${name}" && \
		sudo -u jenkins ant build -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}

# Code quality for a CakePHP 3.x plugin

function cake3_plugin_quality() {
	name="$1"

	cake3_plugin_check "${name}" && \
		cake3_clear &>/dev/null && \
		echo "Quality for the CakePHP 3.x plugin ${name}" && \
		sudo -u jenkins ant quality -f "plugins/${name}/vendor/Jenkins/build.xml"

	return $?
}
```