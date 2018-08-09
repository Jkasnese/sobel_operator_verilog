import serial

with serial.Serial('/dev/ttyUSB0', 115200, timeout=60) as s:
    print(s.name)
    print(s)

    # Writes the size of the image (in bytes) to be transmited. Most significative byte first, then less significative.
    s.write(b'\x00\xb03\x84') # 900

    # Writes the image length
    s.write(b'\x1E') # 30

    img = (b'\x00')
    
    for i in range(59):
        img += (b'\x00')
    for i in range(60):
        img += (b'\x10')
    for i in range(60):
        img += (b'\x20')
    for i in range(60):
        img += (b'\x30')
    for i in range(60):
        img += (b'\x40')
    for i in range(60):
        img += (b'\x50')
    for i in range(60):
        img += (b'\x60')
    for i in range(60):
        img += (b'\x70')
    for i in range(60):
        img += (b'\x80')
    for i in range(60):
        img += (b'\x90')
    for i in range(60):
        img += (b'\xA0')
    for i in range(60):
        img += (b'\xB0')
    for i in range(60):
        img += (b'\xC0')
    for i in range(60):
        img += (b'\xD0')
    for i in range(60):
        img += (b'\xE0')
    for i in range(60):
        img += (b'\xF0')

    s.write(img)

    s.close()

    print('over')

# http://pyserial.readthedocs.io/en/latest/shortintro.html
