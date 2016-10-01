# cakephp-scripts

Various scripts for CakePHP 3.x

## bash

### CakePHP 3.x

Bash functions to work with CakePHP 3.x plugins
Put bash/basrc_cake3.md's content in ~/.basrc_cake3.

- cake3_check
- cake3_clear
- cake3_plugin_phpunit *plugin name*
- cake3_plugin_build *plugin name*
- cake3_plugin_quality *plugin name*

### Slackware development machine

Manage Apache, Mysql, PostgreSQL, ... servers in one command
Put bash/basrc_webserver.md's content in ~/.basrc_webserver.

- webserver
- webserver_chmod
- webserver_restart
- webserver_start
- webserver_stop

## Jenkins

### Cake 3.x plugin jenkins files template

Copy the files in jenkins/cake3_plugin in your plugin's vendor/Jenkins directory.

You have to replace the word "Translator" with your plugin name in the files after the copy.
Change the hard-coded custom workspace path "/var/www/htdocs/cakephp/3.2.x/3.2.2"
in the jobs/build.xml and jobs/quality.xml.

```bash
cake3_plugin_phpunit Translator

wget http://localhost:8080/jnlpJars/jenkins-cli.jar
/usr/lib/java/bin/java -jar jenkins-cli.jar -s http://localhost:8080/ create-job "CakePHP 3 Plugin Translator" < "plugins/Translator/vendor/Jenkins/jobs/build.xml"
/usr/lib/java/bin/java -jar jenkins-cli.jar -s http://localhost:8080/ create-job "CakePHP 3 Plugin Translator Quality" < "plugins/Translator/vendor/Jenkins/jobs/quality.xml"
```