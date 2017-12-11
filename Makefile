CROSS_COMPILE := arm-linux-gnueabihf-

CC := ${CROSS_COMPILE}gcc
AS := ${CROSS_COMPILE}as
LD := ${CROSS_COMPILE}ld
OBJCOPY := ${CROSS_COMPILE}objcopy
OBJDUMP := ${CROSS_COMPILE}objdump

#OPTIMIZATION_FLAGS = -O2
CFLAGS := -mcpu=cortex-a8
CFLAGS += -mfpu=neon
CFLAGS += ${OPTIMIZATION_FLAGS}
ASFLAGS := -mcpu=cortex-a8
#ASFLAGS += -mfpu=neon
#LDFLAGS = -T first.lds
LDFLAGS = -T linker.lds
LDFLAGS += -Map=$*.map

all:bbb_bare_led.o
	$(AS) $(CFLAGS) bbb_bare_led.s -o bbb_bare_led
	$(OBJCOPY) bbb_bare_led.o bbb_bare_led.bin -O binary
#	$(LD) $(LDFLAGS) bbb_bare_led.o later
clean:
	rm *.o *.bin

#SRC = bbb_bare_led.s
#OBJ = $(SRC:.s=.o)

#%.o:%.s
#	$(AS) $(SRC) -o $@





