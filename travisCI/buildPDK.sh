cd  $PDK_ROOT
rm -rf skywater-pdk
git clone https://github.com/google/skywater-pdk.git skywater-pdk
cd skywater-pdk
git checkout -qf 3f310bcc264df0194b9f7e65b83c59759bb27480
git submodule update --init libraries/$STD_CELL_LIBRARY/latest
make $STD_CELL_LIBRARY
cd $PDK_ROOT
rm -rf open_pdks
git clone https://github.com/RTimothyEdwards/open_pdks.git open_pdks
cd open_pdks
git checkout -qf 60b4f62aabff2e4fd9df194b6db59e61a2bd2472
./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-local-path=$PDK_ROOT
make
make install-local
