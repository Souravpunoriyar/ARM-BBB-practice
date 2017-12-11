/*Blinking led in beaglebone black
 *from schematic- GPIO1_21 connected to USR0 led
 *using assembler directives and am335x trm
 * */

.equ CM_PER_GPIO1_CLKCTRL, 0x44e000AC
.equ GPIO1_OE, 0x4804C134
.equ GPIO1_SETDATAOUT, 0x4804C194

_start:
/*Setting SVC mode and disabling the irq */
	mrs r0, cpsr
	bic r0, r0, #0x1F
	orr r0, r0, #0x13
	orr r0, r0, #0xC0
	msr cpsr, r0

/*need to set the functional clock for gpio1 module*/
	ldr r0, =CM_PER_GPIO1_CLKCTRL
	ldr r1, =0x40002
	str r1, [r0]

/*setting pin 21 as output pin*/
	ldr r0, =GPIO1_OE
	ldr r1, [r0]
	bic r1, r1, #(1<<21)
	str r1, [r0]

/*turing pin 1*/
	ldr r0, =GPIO1_SETDATAOUT
	ldr r2, [r0]
	orr r2, r2, #0x200000
	str r2, [r0]

.wait:
	b .wait
