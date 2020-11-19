cd $PDK_ROOT/open_pdks
./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
cd sky130
make veryclean
make
make install-local
