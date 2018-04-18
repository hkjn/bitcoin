#!/usr/bin/env python3

"""
Sample script of using ZMQ to stream out mempool data, via #bitcoin-core-dev.
"""

import datetime
import array
import binascii
import zmq
#import bitcoin.core
import time
import sys

port = 28332

zmqContext = zmq.Context()
zmqSubSocket = zmqContext.socket(zmq.SUB)
zmqSubSocket.setsockopt(zmq.SUBSCRIBE, b"hashblock")
zmqSubSocket.setsockopt(zmq.SUBSCRIBE, b"hashtx")
zmqSubSocket.setsockopt(zmq.SUBSCRIBE, b"rawblock")
zmqSubSocket.setsockopt(zmq.SUBSCRIBE, b"rawtx")
zmqSubSocket.connect("tcp://127.0.0.1:%i" % port)

which = 0
f = sys.stdout

try:
    while True:
        msg = zmqSubSocket.recv_multipart()
        topic = msg[0].decode('utf8')
        body = binascii.hexlify(msg[1]).decode('utf8')

        if topic == 'rawblock': # or topic == 'rawtx':
            continue

        t = time.time()
        nextwhich = datetime.datetime.now().strftime("%Y%m%d")
        if int(which) != int(nextwhich):
            f.close()
            f = open("seen-txns-blocks.%s" % (nextwhich,), "a")
            which = nextwhich

        f.write("%.2f %s %s\n" % (t, topic, body))
        f.flush()

except KeyboardInterrupt:
    zmqContext.destroy()
