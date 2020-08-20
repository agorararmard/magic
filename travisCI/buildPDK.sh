cd $PDK_ROOT/open_pdks
./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-local-path=$PDK_ROOT
make
make install-local
