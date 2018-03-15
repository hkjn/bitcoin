FROM hkjn/arch

COPY gpg.conf /etc/pacman.d/gnupg/
 
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm git base-devel boost flake8 libevent libunwind python python-pip valgrind
RUN pip3 install python-bitcoinlib

# Build and run with:
# docker build -t bitcoin-dev .
# docker run --rm -it --name dev -v $(pwd):/usr/local/src/bitcoin -w /usr/local/src/bitcoin bitcoin-dev bash

# Generate configs and compile with:
#  ./autogen.sh
#  ./configure --disable-wallet
# make
 
# With wallet support: 
#  ./autogen.sh
#  ./contrib/install_db4.sh $(pwd)
#  export BDB_PREFIX='/src/db4'
#  ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"
#  make

# With wallet support, after patches to fix depends system:
#   ./autogen.sh
#    cd depends && make NO_QT=1 && cd ..
#    ./configure --prefix=$(pwd)/depends/armv7l-unknown-linux-gnueabihf
#    make
