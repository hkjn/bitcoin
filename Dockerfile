FROM hkjn/arch

RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm git base-devel boost libevent python

# Run with:
# docker run --rm -it -v $(pwd):/usr/local/src/bitcoin -w /usr/local/src/bitcoin bitcoin-dev sh

# Generate configs and compile with:
#  ./autogen.sh
#  ./configure
# make
  

