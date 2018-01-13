FROM hkjn/arch

COPY gpg.conf /etc/pacman.d/gnupg/
 
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm git base-devel boost flake8 libevent python

# Run with:
# docker run --rm -it -v $(pwd):/usr/local/src/bitcoin -w /usr/local/src/bitcoin bitcoin-dev sh

# Generate configs and compile with:
#  ./autogen.sh
#  ./configure
# make
  

