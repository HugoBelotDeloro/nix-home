function tar-help --description 'Prints help for the tar command'
  printf "\t%s\n" \
  "tar cvf archive.tar file1 file2 file3" \
  "c: create archive" \
  "v: verbose (print file names)" \
  "f: file (next argument is output file)" \
  "tar xvf archive.tar" \
  "x: extract archive" \
  "tar tvf" \
  "t: table of content (print archive contents)" \
end
