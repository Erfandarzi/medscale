import os
import re
for item in os.listdir("out"):
    file_path="out/"+item
    f = open(file_path, "r")
    log = f.read()
    f.close()
    f = open(file_path, "w")
    datalist=re.split(r"the current machine",log)[-1]
    f.write(datalist)
