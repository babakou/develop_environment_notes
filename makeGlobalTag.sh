#!/usr/bin/bash

root_dirs=("./stack" "./hardware" "./drivers" "./apps")
taggedFileList="./taggedFileList.txt"

if [ -e ${taggedFileList} ]; then
    rm ${taggedFileList}
fi

for root_dir in ${root_dirs[@]}; do
    find ${root_dir} -type f -name "*.[h|hpp|c|cpp|cxx|cc]" -print >> taggedFileList.txt
done

gtags -f ${taggedFileList}
