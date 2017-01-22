#!/bin/bash
USER="cbuffin"
GROUP="apache"
COMPOSER="../../composer.phar"
PLUGIN="cakephp3-postgres"
PLUGIN_NAME="Postgres"

function composer_install {
    version="$1"
    dir="${PLUGIN}/$2"

	# cakephp3-database
	# sed -i "s/Mysql',/Postgres',/g" config/app.php && \
	# echo "Plugin::load('${PLUGIN_NAME}', ['autoload' => true]);" >> config/bootstrap.php && \

	# cakephp3-postgres
	# sed -i "s/Mysql',/Postgres',/g" config/app.php && \
	# sed -i "s/'driver' => 'Cake/'driver' => 'Postgres/g" config/app.php && \
	# echo "Plugin::load('${PLUGIN_NAME}', ['autoload' => true, 'bootstrap' => true]);" >> config/bootstrap.php && \

    sudo rm -rf ${dir} && \
    php composer.phar create-project \
        --ignore-platform-reqs \
        --prefer-dist \
        --no-install \
        cakephp/app:${version} ${dir}

    (
        cd ${dir} && \
        php ${COMPOSER} require --ignore-platform-reqs \
            cakephp/cakephp:${version} \
            jmjjg/${PLUGIN}:dev-master && \
        php ${COMPOSER} require --dev --ignore-platform-reqs \
            phpunit/phpunit \
            squizlabs/php_codesniffer \
            cakephp/cakephp-codesniffer \
            phploc/phploc \
            phpmd/phpmd \
            sebastian/phpcpd \
            wimg/php-compatibility && \
        php ${COMPOSER} dump-autoload && \
        mv vendor/wimg/php-compatibility/ vendor/wimg/PHPCompatibility/ && \
        vendor/bin/phpcs --config-set installed_paths vendor/cakephp/cakephp-codesniffer/,vendor/wimg && \
        mv config/app.default.php config/app.php && \
        sed -i "s/Mysql',/Postgres',/g" config/app.php && \
        sed -i "s/'driver' => 'Cake/'driver' => 'Postgres/g" config/app.php && \
        sed -i "s/'UTC'/'Europe\/Paris'/g" config/app.php && \
        sed -i "s/'en_US'/'fr_FR'/g" config/bootstrap.php && \
        sed -i "s/'en_US'/'fr_FR'/g" config/app.php && \
        echo "" >> config/bootstrap.php && \
        echo "Plugin::load('${PLUGIN_NAME}', ['autoload' => true, 'bootstrap' => true]);" >> config/bootstrap.php && \
        sudo chown -R ${USER}:${GROUP} . && \
        sudo chmod -R g+w logs && \
        sudo chmod -R g+w tmp && \
        vendor/bin/phpcs \
            --standard=PHPCompatibility \
            --extensions=php,ctp \
            --runtime-set testVersion 7.0 \
            src
    )
}

function plugin_update {
    dir="${PLUGIN}/$1"

    (
        cd ${dir}/vendor/jmjjg/${PLUGIN} && \
        git pull
    )
}

function plugin_test {
    dir="${PLUGIN}/$1"

    (
        cd ${dir} && \
        sudo rm -rf logs/quality && \
        sudo -u apache ant phpunit -f vendor/jmjjg/${PLUGIN}/vendor/Jenkins/build.xml
    )
}

# failure cakephp3-database@cakephp/cakephp (3.0.19)
# failure cakephp3-postgres@cakephp/cakephp (3.0.19)
# composer_install "3.0.*" "3.0.x"
# plugin_update "3.0.x"
plugin_test "3.0.x"

# failure cakephp3-database@cakephp/cakephp (3.1.14)
# success cakephp3-postgres@cakephp/cakephp (3.1.14)
# composer_install "3.1.*" "3.1.x"
# plugin_update "3.1.x"
plugin_test "3.1.x"

# failure cakephp3-database@cakephp/cakephp (3.2.14)
# success cakephp3-postgres@cakephp/cakephp (3.2.14)
# composer_install "3.2.*" "3.2.x"
# plugin_update "3.2.x"
plugin_test "3.2.x"

# success cakephp3-database@cakephp/cakephp (3.3.12)
# success cakephp3-postgres@cakephp/cakephp (3.3.12)
# composer_install "3.3.*" "3.3.x"
# plugin_update "3.3.x"
plugin_test "3.3.x"