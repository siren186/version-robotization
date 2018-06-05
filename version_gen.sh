echo "=========="
echo "enter version_gen.sh"
pwd

# =========================================================
# Get git commit count
git rev-list HEAD | sort > {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp
var_commit_count=`wc -l {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp | awk '{print $1}'`
rm -f {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp

# Get git status
if git status | grep -q "modified:" ; then
    var_modified=" some file modified but not commit"
    echo "warning !!! some file modified but not commit"
else
    var_modified=""
fi

# =========================================================
# Generate string version
var_commit_ts=`git log -1 --format="%ct"`
var_commit_time=`date -d@$var_commit_ts +"%Y%m%d%H%M%S"`
var_current_time=`date +"%Y%m%d%H%M%S"`
var_git_sha1_short=`git log -1 --format="%h"`
var_git_sha1_large=`git log -1 --format="%H"`

cat $1 | sed "s/\$GIT_SHA1/$var_git_sha1_short/g;s/\$GIT_COMMIT_COUNT/$var_commit_count/g;s/\$GIT_STRING/\"sha1:$var_git_sha1_large commit:$var_commit_time build:$var_current_time$var_modified\"/g;" > {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp
[ -n "$2" ] && cp {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp $2
rm -f {81F1B2F1-F37F-480E-8D98-D9BCF3B05CE5}.tmp

echo "version_gen.sh finished"
echo "=========="
