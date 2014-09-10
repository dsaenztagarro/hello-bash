# Assign the current work directory to the bash script variable 'CWD'.
CWD=$(pwd)

# Print it.
# printf "%s\n" ${CWD}

for filename in `find . -name "*.sh"`; do
  cmd="ln -s $CWD $filename /usr/local/bin/$filename"
  echo $cmd
  echo "file = $filename"
done
