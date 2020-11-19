# Linux
1. counting
ls -l | wc -l
2. download
wget -r -p -np -k
3. count storage usage
du --max-depth=1 -h
4. show modified time
stat -c '%y : %n' ./*
5. watch gpu usage
watch -n 0.1 nvidia-smi
