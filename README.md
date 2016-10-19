# cakephp-scripts

Various scripts and templates for CakePHP 2.x and 3.x

## bash

### CakePHP 3.x

Bash functions to work with CakePHP 3.x plugins
Put bash/bashrc_cake3.md's content in ~/.bashrc_cake3.

- cake3_check
- cake3_clear
- cake3_plugin_phpunit *plugin name*
- cake3_plugin_build *plugin name*
- cake3_plugin_quality *plugin name*

### SVN

Manage Apache, Mysql, PostgreSQL, ... servers in one command
Put bash/bashrc_svn.md's content in ~/.bashrc_svn.

- svnbackup

### Slackware development machine

Manage Apache, Mysql, PostgreSQL, ... servers in one command
Put bash/bashrc_webserver_slackware.md's content in ~/.bashrc_webserver_slackware.

- webserver
- webserver_chmod
- webserver_restart
- webserver_start
- webserver_stop

## Jenkins

### Cake 3.x plugin jenkins files template

Have a look at the cake3_plugin/INSTALL.md file.
Copy the files in jenkins/cake3_plugin in your plugin's vendor/Jenkins directory.

You have to replace the word "cake3_plugin" with your plugin name in the files after the copy.
Change the hard-coded custom workspace path "/var/www/htdocs/cakephp/3.2.x/3.2.2"
in the jobs/build.xml and jobs/quality.xml.

Replace "<cake3_plugin>" with your plugin name in the lines below.

```bash
cake3_plugin_phpunit <cake3_plugin>

wget http://localhost:8080/jnlpJars/jenkins-cli.jar
/usr/lib/java/bin/java -jar jenkins-cli.jar -s http://localhost:8080/ create-job "CakePHP 3 Plugin <cake3_plugin>" < "plugins/<cake3_plugin>/vendor/Jenkins/jobs/build.xml"
/usr/lib/java/bin/java -jar jenkins-cli.jar -s http://localhost:8080/ create-job "CakePHP 3 Plugin <cake3_plugin> Quality" < "plugins/<cake3_plugin>/vendor/Jenkins/jobs/quality.xml"
```

## Netbeans

### Cake 3.x netbeans template

#### Install

```bash
~/.netbeans/<version>/config/Templates/CakePHP/v. 3.x.x/
```

Edit `~/.netbeans/8.0.2/config/Templates/CakePHP/.nbattrs` and add:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE attributes PUBLIC "-//NetBeans//DTD DefaultAttributes 1.0//EN" "http://www.netbeans.org/dtds/attributes-1_0.dtd">
<attributes version="1.0">
    <fileobject name="v. 3.x.x">
        <attr name="displayName" stringvalue="v. 3.x.x"/>
    </fileobject>
</attributes>
```

Edit `netbeans/templates/v. 3.x.x/freemarker_functions.ftl` and fill or remove the
3 assign lines (author, license, namespace).

#### @see
- http://freemarker.sourceforge.net/docs/dgui_template_exp.html#dgui_template_exp_stringop_interpolation
- http://freemarker.sourceforge.net/docs/ref_builtins_string.html
- http://wiki.netbeans.org/FaqFreeMarker
- http://wiki.netbeans.org/FaqTemplateVariables
- http://freemarker.org/docs/
- http://freemarker.org/docs/ref_directives.html

## phpcs/Standards/Cake2CodesnifferParanoid

### Classes/AppUses sniff for CakePHP 2.x
Checks that every extended class get an App::uses call for it, except when
extending previously defined classes in the file or classes defined by the SPL or
the Exception class.