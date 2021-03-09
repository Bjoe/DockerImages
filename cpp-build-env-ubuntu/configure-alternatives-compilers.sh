# Cleanup old alternatives
update-alternatives --remove-all cc
update-alternatives --remove-all c++

update-alternatives --remove-all gcc 
update-alternatives --remove-all g++
update-alternatives --remove-all clang
update-alternatives --remove-all clang++
#update-alternatives --remove-all icc
#update-alternatives --remove-all icc++

# Add GCC versions
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 30
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 30

# Add Clang versions
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 30
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 30

# Add ICC versions
#update-alternatives --install /usr/bin/icc icc /opt/intel/compilers_and_libraries/linux/bin/intel64/icc 10
#update-alternatives --install /usr/bin/icc++ icc++ /opt/intel/compilers_and_libraries/linux/bin/intel64/icpc 10

# Add compilers
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
update-alternatives --install /usr/bin/cc cc /usr/bin/clang 40
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 40
#update-alternatives --install /usr/bin/cc cc /usr/bin/icc 50
#update-alternatives --install /usr/bin/c++ c++ /usr/bin/icc++ 50
