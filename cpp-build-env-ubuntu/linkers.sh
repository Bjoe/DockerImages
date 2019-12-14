# Remove existing
update-alternatives --remove-all ld
update-alternatives --remove-all ld.intel

# Add Icc linker
update-alternatives --install /usr/bin/ld.intel ld.intel /opt/intel/compilers_and_libraries/linux/bin/intel64/xild 10

# Add all linkers
update-alternatives --install /usr/bin/ld ld /usr/bin/ld.bfd 10
update-alternatives --install /usr/bin/ld ld /usr/bin/ld.gold 20
update-alternatives --install /usr/bin/ld ld /usr/bin/ld.intel 30

# Choose one
update-alternatives --set ld /usr/bin/ld.bfd
update-alternatives --set ld /usr/bin/ld.gold
update-alternatives --set ld /usr/bin/ld.intel