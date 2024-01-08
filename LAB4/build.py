import os
out_f = open("os.img", "wb")
in_f = open("bootloader.bin", "rb")
out_f.write(in_f.read())

# Addr 2461   Addr = Track * 2 * 18 + Head * 18 + Sector - 1
# Sector - 14  Sect = addr mod 18 + 1
# Head - 0    ((Adress - (Sector-1)) / 18) mod 2
# Track - 68  ((addr - (sec - 1)) /18 - head) / 2

target_size = 1260032 #Adr * 512   1260032
bytes = b'\x00' * (target_size - os.path.getsize("bootloader.bin"))
out_f.write(bytes)

in_f = open("main.bin", "rb")
out_f.write(in_f.read())

target_size = 1474560-512
bytes = b'\x00' * (target_size - os.path.getsize("os.img"))
out_f.write(bytes)