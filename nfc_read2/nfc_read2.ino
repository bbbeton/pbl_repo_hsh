
#include <snep.h>

#include "SPI.h"
#include "PN532.h"
#include "PN532_SPI.h"
#include "NfcAdapter.h"


PN532_SPI interface(SPI, 10); // create a PN532 SPI interface with the SPI CS terminal located at digital pin 10
PN532 nfc(pn532spi);
NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object
String tagId = "None";
 
void setup(void) 
{
 Serial.begin(115200);
 Serial.println("System initialized");
 nfc.begin();
}
 
void loop() 
{
 readNFC();
}
 
void readNFC() 
{
 if (nfc.tagPresent())
 {
   NfcTag tag = nfc.read();
   tag.print();
   tagId = tag.getUidString();
 }
 delay(5000);
}