echo "=========="
echo "run version.sh"
pwd
git rev-list HEAD | sort > config.git-hash
COMMIT_COUNT=`wc -l config.git-hash | awk '{print $1}'`
echo "git commit count = $COMMIT_COUNT"
if [ $COMMIT_COUNT \> 1 ] ; then
    if git status | grep -q "modified:" ; then
        MODIFIED="1"
		echo "warning !!! some file modified but not commit"
	else
        MODIFIED="0"
    fi
    SHA1="$(git rev-list HEAD -n 1 | cut -c 1-7)"
	echo "git commit SHA1 = $SHA1"
else
    echo "error in version.sh, git has no commits"
    COMMIT_COUNT="0"
	MODIFIED="0"
	SHA1="0"
fi
rm -f config.git-hash
cat $1 | sed "s/\$GIT_SHA1/$SHA1/g;s/\$GIT_COMMIT_COUNT/$COMMIT_COUNT/g;s/\$GIT_MODIFIED/$MODIFIED/g;" > version.h
[ -n "$2" ] && cp version.h $2
echo "run version.sh finished"
echo "=========="
