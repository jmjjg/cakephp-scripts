<#assign author = "Christian Buffin ">
<#assign license = "http://www.opensource.org/licenses/mit-license.php MIT License">
<#assign namespace = "App">

<#function underscore name>
	<#return name?replace("([a-z0-9])([A-Z])", "$1_$2", "r")?lower_case>
</#function>

<#function table name>
	<#return underscore(name?replace("(.*)Table", "$1", "r"))>
</#function>

<#function foreign_key name>
  <#return underscore(name) + '_id'>
</#function>