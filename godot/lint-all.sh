
cd root/scripts
find . -name "*.gd" -print0 | xargs -0 gdlint
