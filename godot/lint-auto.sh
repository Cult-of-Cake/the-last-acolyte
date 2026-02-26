find . -type f -name "*.gd" -not -path "./addons/*" > gd_files.txt
echo "Number of files to lint: $(wc -l < gd_files.txt)"
gdlint $(cat gd_files.txt) > gdlint_output.txt 2>&1 || true
cat gdlint_output.txt
rm gd_files.txt
rm gdlint_output.txt