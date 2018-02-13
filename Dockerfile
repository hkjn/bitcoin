FROM hkjn/arch

COPY gpg.conf /etc/pacman.d/gnupg/
 
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm git base-devel boost flake8 libevent python valgrind

# Build and run with:
# docker build -t bitcoin-dev .
# docker run --rm -it --name dev -v $(pwd):/usr/local/src/bitcoin -w /usr/local/src/bitcoin bitcoin-dev bash

# Generate configs and compile with:
#  ./autogen.sh
#  ./configure
# make
  

