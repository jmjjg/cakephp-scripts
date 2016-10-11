```bash
#!/bin/bash
# Put this in your ~/.bashrc_svn then the next 2 lines uncommented in your .bashrc
# eval HOME="~"
# . "${HOME}/.bashrc_svn"

function svnbackup() {
	base="${1}"
	if [ -z "${base}" ] ; then
		base_dir="`readlink -f "."`"
	else
		base_dir="`readlink -f "${base}"`"
	fi

	if [ ! -d "${base_dir}/.svn/" ] ; then
		echo "${base_dir}/.svn/ does not exit"
		return 1
	fi

	xml="`svn info --xml "${base_dir}" | sed ':a;N;$!ba;s/\n/ /g'`"
	path="`echo ${xml} | sed 's/^.*<entry[^>]* path=\"\([^"]*\)\".*$/\1/g'`"
	revision="`echo ${xml} | sed 's/^.*<entry[^>]* revision=\"\([0-9]\+\)\".*$/\1/g'`"
	project="`echo ${xml} | sed 's/^.*<root>.*\/\([^\/]\+\)<\/root>.*$/\1/g'`"
	subfolder="`echo ${xml} | sed 's/^.*<url>.*\/\([^\/]\+\)\/app<\/url>.*$/\1/g'`"

	now=`date +"%Y%m%d-%H%M%S"`
	patch_dir="${base_dir}/../svnbackup-${project}_${subfolder}-r${revision}-${now}"
	patch_dir="`readlink -f "${patch_dir}"`"

	mkdir -p "${patch_dir}"
	if [[ $? -ne 0 ]] ; then
		echo "Could not create directory ${patch_dir}"
		exit 1
	fi

	(
		cd "${base_dir}"
		local SAVEIFS=${IFS}
		IFS=$(echo -en "\n\b")

		status="`svn status . | grep -v "\(^\(\!\|D\)\|>\)" | sed 's/^\(.\{8\}\)\(.*\)$/\2/'`";
		for file in `echo "${status}"`; do
			dir="`dirname "${file}" | sed "s@^\./@${PWD}@"`"
			if [ "${dir}" != '.' ] ; then
				mkdir -p "${patch_dir}/${path}/${dir}"
			fi
			cp -R "${file}" "${patch_dir}/${path}/${dir}"
		done
		IFS=${SAVEIFS}
	)

	(
		cd "${patch_dir}"
		svnbackup_subdir="`basename "${patch_dir}"`"

		zip -o -r -m "../${svnbackup_subdir}.zip" "${path}" >> "/dev/null" 2>&1
		success=$?

		if [[ ${success} -ne 0 ]] ; then
			echo "Could not create the ${svnbackup_subdir}.zip file"
		else
			echo "File ${svnbackup_subdir}.zip created"
			cd ..
			rmdir "${patch_dir}"
		fi

		return ${success}
	)
}
```