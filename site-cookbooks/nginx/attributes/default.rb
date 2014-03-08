default['nginx']['num_of_procs']=`cat /proc/cpuinfo | grep processor | wc -l`.chomp
