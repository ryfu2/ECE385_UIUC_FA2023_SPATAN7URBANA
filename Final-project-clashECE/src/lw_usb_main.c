#include <stdio.h>
#include "platform.h"
#include "stdlib.h"
#include "string.h"
#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/USB.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/transfer.h"
#include "lw_usb/HID.h"

#include "xparameters.h"
#include <xgpio.h>

extern HID_DEVICE hid_device;

static XGpio Gpio_hex;

static BYTE addr = 1; 				//hard-wired USB address
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };
BYTE GetDriverandReport() {
	BYTE i;
	BYTE rcode;
	BYTE device = 0xFF;
	BYTE tmpbyte;

	DEV_RECORD* tpl_ptr;
	xil_printf("Reached USB_STATE_RUNNING (0x40)\n");
	for (i = 1; i < USB_NUMDEVICES; i++) {
		tpl_ptr = GetDevtable(i);
		if (tpl_ptr->epinfo != NULL) {
			xil_printf("Device: %d", i);
			xil_printf("%s \n", devclasses[tpl_ptr->devclass]);
			device = tpl_ptr->devclass;
		}
	}
	//Query rate and protocol
	rcode = XferGetIdle(addr, 0, hid_device.interface, 0, &tmpbyte);
	if (rcode) {   //error handling
		xil_printf("GetIdle Error. Error code: ");
		xil_printf("%x \n", rcode);
	} else {
		xil_printf("Update rate: ");
		xil_printf("%x \n", tmpbyte);
	}
	xil_printf("Protocol: ");
	rcode = XferGetProto(addr, 0, hid_device.interface, &tmpbyte);
	if (rcode) {   //error handling
		xil_printf("GetProto Error. Error code ");
		xil_printf("%x \n", rcode);
	} else {
		xil_printf("%d \n", tmpbyte);
	}
	return device;
}

void printHex (u32 data, unsigned channel)
{
	XGpio_DiscreteWrite (&Gpio_hex, channel, data);
}


int main() {
    init_platform();
    XGpio_Initialize(&Gpio_hex, XPAR_GPIO_USB_KEYCODE_DEVICE_ID);
   	XGpio_SetDataDirection(&Gpio_hex, 1, 0x00000000); //configure hex display GPIO
   	XGpio_SetDataDirection(&Gpio_hex, 2, 0x00000000); //configure hex display GPIO


   	BYTE rcode;
	BOOT_MOUSE_REPORT buf;		//USB mouse report
	BOOT_KBD_REPORT kbdbuf;

	BYTE runningdebugflag = 0;//flag to dump out a bunch of information when we first get to USB_STATE_RUNNING
	BYTE errorflag = 0; //flag once we get an error device so we don't keep dumping out state info
	BYTE device;
	xil_printf("initializing MAX3421E...\n");
	MAX3421E_init();
	xil_printf("initializing USB...\n");
    volatile uint32_t* songdata = 0x40010000;
    volatile uint32_t* readena = 0x40000000;
    volatile uint32_t* reset = 0x40050000;
    volatile uint32_t* continueb = 0x40060000;
    volatile int song1count = 0;
    volatile int songnum = 1;
    volatile int song2count = 0;
    volatile int song3count = 0;
	USB_init();
	while (1) {
//		xil_printf("."); //A tick here means one loop through the USB main handler
		MAX3421E_Task();
		USB_Task();
		if (*continueb) {
			while (*continueb) {
				continue;
			}
			if (songnum == 2) {
				songnum = 3;
				song1count = 0;
				song2count = 0;
				song3count = 0;
			} else if (songnum == 1) {
				songnum = 2;
				song3count = 0;
				song2count = 0;
				song1count = 0;
			} else {
				songnum = 1;
				song1count = 0;
				song2count = 0;
				song3count = 0;
			}
		}
		if (*readena && songnum == 1) {
			for (int i = 0; i < 4000; i ++){
				if (song1count >= 910114) {
					songnum = 2;
					song1count = 0;
					}
				if (song1count <= 910114 && song1count >= 898414) {
					*songdata = 0;
					song1count += 1;
					continue;
				}
				*songdata = song[song1count];
				*songdata = 0b00000000000000000000000000000000;
				song1count += 1;
			}
		}
		else if (*readena && songnum == 2) {
			for (int i = 0; i < 4000; i ++){
				if (song2count >= 754530) {
					songnum = 1;
					song2count = 0;
					}
				*songdata = song2[song2count];
				*songdata = 0b10000000000000000000000000000000;
				song2count += 1;
			}
		}
		else if (*readena && songnum == 3) {
			for (int i = 0; i < 4000; i ++){
				if (song3count >= 664463) {
					songnum = 1;
					song3count = 0;
					}
				*songdata = song3[song3count];
				*songdata = 0b10000000000000000000000000000000;
				song3count += 1;
			}
		}
		if (*reset){
			xil_printf("reset");
			printHex (0, 1);
			while (*reset) {
				printHex (0, 1);
				song1count = 0;
				song2count = 0;
				song3count = 0;
				songnum = 1;
			}
			sleep(2);
			printHex ((u32)(1 << 24) + (u32)(0<< 16) + (u32)0, 1);
		};
		if (GetUsbTaskState() == USB_STATE_RUNNING) {
			if (!runningdebugflag) {
				runningdebugflag = 1;
				device = GetDriverandReport();
			} else if (device == 1) {
				//run keyboard debug polling
				rcode = kbdPoll(&kbdbuf);
				if (rcode == hrNAK) {
					continue; //NAK means no new data
				} else if (rcode) {
					xil_printf("Rcode: ");
					xil_printf("%x \n", rcode);
					continue;
				}
				xil_printf("keycodes: ");
				for (int i = 0; i < 6; i++) {
					xil_printf("%x ", kbdbuf.keycode[i]);
				}
				//Outputs the first 4 keycodes using the USB GPIO channel 1
				printHex (kbdbuf.keycode[0] + (kbdbuf.keycode[1]<<8) + (kbdbuf.keycode[2]<<16) + + (kbdbuf.keycode[3]<<24), 1);
				//Modify to output the last 2 keycodes on channel 2.
				xil_printf("\n");
			}

			else if (device == 2) {
				rcode = mousePoll(&buf);
				if (rcode == hrNAK) {
					//NAK means no new data
					printHex ((u32)(1 << 24) + (u32)(buf.button << 16) + (u32)0, 1);
				}
				else if (rcode == 6 && buf.Ydispl == 0 && buf.Xdispl == 0 && buf.button == 0) {
					xil_printf("Rcode: ");
					xil_printf("%x\n", rcode);
				    printHex ((u32)(1 << 24) + (u32)(1 << 16) + (u32)(buf.Ydispl << 8) + (u32)(buf.Xdispl), 1);
	                buf.button = 0;
				}
				else if (rcode == 6 && buf.Ydispl == 0 && buf.Xdispl == 0 && buf.button == 1) {
					xil_printf("Rcode: ");
					xil_printf("%x\n", rcode);
				    printHex ((u32)(1 << 24) + (u32)(0 << 16) + (u32)(buf.Ydispl << 8) + (u32)(buf.Xdispl), 1);
	                buf.button = 0;
				}
				else if (rcode == 6 && (buf.Ydispl != 0 || buf.Xdispl != 0) && buf.button == 0) {
					xil_printf("Rcode: ");
					xil_printf("%x\n", rcode);
				    printHex ((u32)(1 << 24) + (u32)(0 << 16) + (u32)(buf.Ydispl << 8) + (u32)(buf.Xdispl), 1);
	                buf.button = 0;
				}
				else {
					xil_printf("X displacement: ");
					xil_printf("%d ", (signed char) buf.Xdispl);
					xil_printf("Y displacement: ");
					xil_printf("%d ", (signed char) buf.Ydispl);
					xil_printf("Buttons: ");
					xil_printf("%x\n", buf.button);
					printHex ((u32)(1 << 32) + (u32)(1 << 24) + (u32)(buf.button << 16) + (u32)(buf.Ydispl << 8) + (buf.Xdispl), 1);
				}
			}
		} else if (GetUsbTaskState() == USB_STATE_ERROR) {
			if (!errorflag) {
				errorflag = 1;
				xil_printf("USB Error State\n");
				//print out string descriptor here
			}
		} else //not in USB running state
		{

//			xil_printf("USB task state: ");
//			xil_printf("I find you!");
//			xil_printf("%x\n", GetUsbTaskState());
			if (runningdebugflag) {	//previously running, reset USB hardware just to clear out any funky state, HS/FS etc
				runningdebugflag = 0;
				MAX3421E_init();
				USB_init();
			}
			errorflag = 0;
		}

	}
    cleanup_platform();
	return 0;
}

//int main() {
//    init_platform();
//    volatile uint32_t* readready = 0x40000000;
//    volatile uint32_t* songdata = 0x40010000;
//    volatile int songcount = 0;
//    volatile int truereadready = 1;
//    while (1) {
//	   	if (truereadready) {
//	   		if (songcount == 1425980) {
//	   			songcount = 0;
//	   		}
//	   		*songdata = song[songcount];
//	   		songcount += 1;
//	   	}
//	   	if (truereadready == 0 && *readready == 1) {
//	   		truereadready = 1;
//	   	} else if (truereadready == 0 && *readready == 0){
//	   		truereadready = 0;
//	   	} else if (truereadready == 1 && *readready == 1) {
//	   		truereadready = 0;
//	   	} else if (truereadready == 1 && *readready == 0){
//	   		truereadready = 0;
//	   	}
//    };
//    cleanup_platform();
//	return 0;
//
//};


