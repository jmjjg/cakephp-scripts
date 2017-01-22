#!/bin/bash
USER="cbuffin"
GROUP="apache"

function composer_install {
    version="$1"
    dir="$2"

    sudo rm -rf ${dir} && \
    php composer.phar create-project \
        --ignore-platform-reqs \
        --prefer-dist \
        --no-install \
        cakephp/app:${version} ${dir}

    (
        cd ${dir} && \
        php ../composer.phar require --ignore-platform-reqs \
            cakephp/cakephp:${version} \
            jmjjg/cakephp3-database:dev-master \
            jmjjg/cakephp3-postgres:dev-master && \
        php ../composer.phar require --dev --ignore-platform-reqs \
            phpunit/phpunit \
            squizlabs/php_codesniffer \
            cakephp/cakephp-codesniffer \
            phploc/phploc \
            phpmd/phpmd \
            sebastian/phpcpd \
            wimg/php-compatibility && \
        php ../composer.phar dump-autoload && \
        mv vendor/wimg/php-compatibility/ vendor/wimg/PHPCompatibility/ && \
        vendor/bin/phpcs --config-set installed_paths vendor/cakephp/cakephp-codesniffer/,vendor/wimg && \
        mv config/app.default.php config/app.php && \
        sed -i "s/Mysql',/Postgres',/g" config/app.php && \
        sed -i "s/'UTC'/'Europe\/Paris'/g" config/app.php && \
        sed -i "s/'en_US'/'fr_FR'/g" config/bootstrap.php && \
        sed -i "s/'en_US'/'fr_FR'/g" config/app.php && \
        echo "" >> config/bootstrap.php && \
        echo "Plugin::load('Database', ['autoload' => true]);" >> config/bootstrap.php && \
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
    dir="$1"

    (
        cd ${dir}/vendor/jmjjg/cakephp3-database && \
        git pull
    )
}

function plugin_test {
    dir="$1"

    (
        cd ${dir} && \
        sudo rm -rf logs/quality && \
        sudo -u apache ant phpunit -f vendor/jmjjg/cakephp3-database/vendor/Jenkins/build.xml
    )
}

# failure @cakephp/cakephp (3.0.19)
# composer_install "3.0.*" "3.0.x"
plugin_update "3.0.x"
plugin_test "3.0.x"

# failure @cakephp/cakephp (3.1.14)
# composer_install "3.1.*" "3.1.x"
plugin_update "3.1.x"
plugin_test "3.1.x"

# failure @cakephp/cakephp (3.2.14)
# composer_install "3.2.*" "3.2.x"
plugin_update "3.2.x"
plugin_test "3.2.x"

# success @cakephp/cakephp (3.3.12)
# composer_install "3.3.*" "3.3.x"
plugin_update "3.3.x"
plugin_test "3.3.x"