import oscP5.*;
import netP5.*;

PFont myFont;
PImage drzwi_zamkniete_photo;
PImage drzwi_zamkniete_photo_dark;
PImage drzwi_otwarte_photo; 
PImage drzwi_otwarte_photo_dark; 
PImage temp_otwarte;
PImage temp_zamkniete;

PImage ustawienia_przed_photo;
PImage ustawienia_po_photo;
PImage kamera_przed_photo;
PImage kamera_po_photo;
PImage newMember_przed_photo;
PImage newMember_po_photo;
PImage historia_przed_photo;
PImage historia_po_photo;
PImage ikona_drzwi_po;
PImage ikona_drzwi;
PImage ikona_kamera;

String logo = "Home Sweet Home";
float time;
//animation step
float a;
float b;
float c;
int y;
int k;
// colors
// background colors bright
float xb=0;
float yb=149;
float zb=255;
// background colors dark
float xd = 13;
float yd = 32;
float zd = 140;
// text colors on the background
float xc = 250; 
float yc = 250;
float zc = 250;
// button colors
float xp = 200;
float yp = 200;
float zp = 200;
Letter[] letters;

String message= "Home Sweet Home";
int opcje = 3;
int wifi;

//wifi
String remoteIP = "192.168.0.227";      //local IP plytki ESP
int remotePort = 8888;                  //port do wysylania
int localPort = 9999;                   //lokalny port
int otwarcie_drzwi = 0;

OscP5 oscP5;
NetAddress myRemoteLocation;

// klawiatura 

//import android.app.PendingIntent;
//import android.content.Intent;
//import android.os.Bundle;
import ketai.net.nfc.*;
import ketai.ui.*;                                        // 1

KetaiNFC ketaiNFC;

String firstText = "";
String secondText = "";
String thirdText = "";
int tempText;               // 2

void setup() {
  orientation(PORTRAIT); 
  fullScreen();
  fill(0);
  background(xb, yb, zb);
  //wifi
  oscP5 = new OscP5(this,localPort);
  myRemoteLocation = new NetAddress(remoteIP,remotePort);
  
  drzwi_zamkniete_photo = loadImage("drzwi_zamkniete.png");
  drzwi_otwarte_photo = loadImage("drzwi_otwarte.png");
  drzwi_zamkniete_photo_dark = loadImage("drzwi_zamkniete_dark.png");
  drzwi_otwarte_photo_dark = loadImage("drzwi_otwarte_dark.png");
  temp_zamkniete = loadImage("drzwi_zamkniete.png");
  temp_otwarte = loadImage("drzwi_otwarte.png");
  
  ustawienia_przed_photo = loadImage("ustawienia_przed.png");
  ustawienia_po_photo = loadImage("ustawienia_po.png");
  kamera_przed_photo = loadImage("kamera_przed.png");
  kamera_po_photo = loadImage("kamera_po.png");
  newMember_przed_photo = loadImage("newMember_przed.png");
  newMember_po_photo = loadImage("newMember_po.png");
  historia_przed_photo = loadImage("log_wejsc_przed.png");
  historia_po_photo = loadImage("log_wejsc_po.png");
  ikona_drzwi_po = loadImage("ikona_drzwi_po.png");
  ikona_drzwi = loadImage("ikona_drzwi.png");
  ikona_kamera = loadImage("ikona_kamera.png");
  myFont = loadFont("Bauhaus93-120.vlw"); //czcionka
  
  //myFont = createFont("Bauhaus93-120", 32);
  
  textFont(myFont);
  // Create the array the same size as the String
  letters = new Letter[message.length()];
  // Initialize Letters at the correct x location
  int x = 60;
  for (int i = 0; i < message.length(); i++) {
   letters[i] = new Letter(x,1100,message.charAt(i));
   x += textWidth(message.charAt(i));
   
   if (ketaiNFC == null)
    ketaiNFC = new KetaiNFC(this);
  
  }
}
void draw() {
  /*
 ZAKOMENTOWANE DO CZASU PRACY NAD RESZTĄ KODU
 -------------------------------------
 if(millis()<6000)
 {
    time=5000/30;
  background(xb, yb, zb);
 for (int i = 0; i < letters.length + 15; i++) {
    // Display all letters
a=15.333333333;
b=5.4;
c=1.666666666;
    if(millis()>time)
    {
      if(i>=15)
      {
        y=15;
         for(k=i-15; k<15;k++)
      {
         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
         y--;
      }
      for(k=i-15;k>=0;k--)
      letters[k].display(230,230,230);
      }
      else
      {
        y=1;
      for(k=i; k>=0;k--)
      {
         letters[k].display(y*a+xb,y*b +yb,zb-y*c);
         y++;
      }
      }
      
    }
    time+=5000/30;
  }
  }
  else
  {
    */
  // różne strony
  switch(opcje){
  case 1: 
    SiteHistoriaWejsc();
    break;
  case 2:
    SiteKamerka();
    break;
  case 3:
    OpenDoorSite();
    if(otwarcie_drzwi == 22){
      fill(9, 74, 171);
      strokeWeight(5);
      stroke(230);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      image(temp_otwarte, 140, 0, 1100, 1100);
<<<<<<< HEAD
=======
    }
    else if(otwarcie_drzwi == 13)
    {
      fill(0, 149, 255);
      strokeWeight(5);
      stroke(xc, yc, zc);
      rect(380, 1100,300,300,30);
      triangle(468, 1170, 468, 1330, 609,1250);
      image(drzwi_zamkniete_photo, 140, 0, 1100, 1100);
>>>>>>> 89339f7e3e94828b78a1ec61f32512c51b7774be
    }
    break;
  case 4:
    SiteNewMember();
    break;
  case 5:
    SiteUstawienia();
    break;
  case 6:
    SiteAddingNewMember();
  break;
  default:
    break;
  }

  } 
//} DO ODKOMENTOWANIA GDY BEDZIEMY WLACZAC OTWIERANIE APKI
class Letter {
  char letter;
  // The object knows its original "home" location
  float homex,homey;
  // As well as its current location
  float x,y;

  Letter (float x_, float y_, char letter_) {
    homex = x = x_;
    homey = y = y_;
    letter = letter_;
  }

  // Display the letter
  void display(float a,float b,float c) {
      fill(a,b,c);
    text(letter,x,y);
  }
}
 void OpenDoorSite()
{
background(xb, yb, zb);
noStroke();
dolnyPasek();
image(ikona_drzwi_po, 2*width/5, 2050, width/5, width/5);
fill(xc, yc, zc);
image(temp_zamkniete, 140, 0, 1100, 1100);

fill(0, 149, 255);
strokeWeight(5);
stroke(xc, yc, zc);
rect(380, 1100,300,300,30);
triangle(468, 1170, 468, 1330, 609,1250);
fill(xc, yc, zc);
textSize(70);
textAlign(CENTER, BOTTOM);
text("Click here to open the door", width/2, 1500);

  // tu dodać ifa zamykajacego obrazek drzwi gdy drzwi zostana zamkniete albo uplynie czas

}

void mousePressed()
{
  //clicking options
    // historia wejść
    if ( mouseX < width/5 && mouseY > 2050) {
      opcje=1;
    } 
    // kamera
    if ( mouseX > width/5 && mouseX < 2*width/5 && mouseY > 2050) {
      opcje=2;
    } 
    // strona główna
    if ( mouseX > 2*width/5 && mouseX < 3*width/5 && mouseY > 2050) {
      opcje=3;
    }
    // adding a new member
    if ( mouseX > 3*width/5 && mouseX < 4*width/5 && mouseY > 2050) {
      opcje=4;
    } 
    // ustawienia
    if ( mouseX > 4*width/5 && mouseY > 2050) {
      opcje=5;
    }
    switch(opcje){
  case 1: 
    break;
  case 2:
    if (mouseX > width/2-400 && mouseX < width/2+400 && mouseY > height/2-350 && mouseY < height/2+350 ) {
      link("http://192.168.31.190/mjpeg/1");
    }
    break;
  case 3:
    if (mouseX > 380 && mouseX < 680 && mouseY > 1100 && mouseY < 1400 ) {
      otwarcie_drzwi = 22;
      OscMessage myMessage = new OscMessage("/int");
      myMessage.add(otwarcie_drzwi);
      oscP5.send(myMessage, myRemoteLocation); 
    } 
    break;
  case 4:
  //clik here to add a new member
    if (mouseX > width/3 && mouseX < 2*width/3 && mouseY > height/3 && mouseY < (height/3 + height/7) ) {
      opcje=6;
    }
    break;
  case 5:
    
    break;
  case 6:{
  if (mouseX > 0 && mouseX < 50 && mouseY > 0 && mouseY < 50) {
      opcje=4;
  }
    // otwieranie klawiatury
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 150 && mouseY < 250 ){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    firstText = "";
    tempText=1;
    
  }
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 550 && mouseY < 650){
    // klawiatura
    KetaiKeyboard.toggle(this);                             
    secondText = "";
    tempText=2;
  }
  if (mouseX > (width/8) && mouseX < (7*width/8) && mouseY > 950 && mouseY < 1050 ){
    // klawiatura
    KetaiKeyboard.toggle(this);
    thirdText = "";
    tempText=3;
  }

  break;
    }
  default:
    break;
  } 
}

void dolnyPasek(){
  rect(0, 2050, 0, 0, 0);
  image(historia_przed_photo, 0, 2050, width/5, width/5);
  image(kamera_przed_photo, width/5, 2050, width/5, width/5);
  image(ikona_drzwi, 2*width/5, 2050, width/5, width/5);
  image(newMember_przed_photo, 3*width/5, 2050, width/5, width/5);
  image(ustawienia_przed_photo, 4*width/5, 2050, width/5, width/5);
}
// historia wejsc strona 1
void SiteHistoriaWejsc(){
  background(xb, yb, zb);
  dolnyPasek();
  image(historia_po_photo, 0, 2050, width/5, width/5);
  fill(xc, yc, zc);
  rect(width/7, width/7, 5*width/7, 5*height/7, 15);
  // wstawiamy liste kto wchodzil 

}
// kamerka strona 2
void SiteKamerka(){
  background(xb, yb, zb);
  dolnyPasek();
  image(kamera_po_photo, width/5, 2050, width/5, width/5);
  // tu trzeba dodać link do strony z widokiem z kamerki
  fill(250);
  textSize(100);
  text("Click the icon to see camera view",100,100,850,500);
  image(ikona_kamera,width/2-500, height/2-500, 1000, 1000);
  
  
}
// nowy czlonek strona 4
void SiteNewMember(){
  background(xb, yb, zb);
  dolnyPasek();
  image(newMember_po_photo, 3*width/5, 2050, width/5, width/5);
  fill(230);
  rect(width/3, height/3, width/3, height/7, 15);
  textSize(70);
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Add", (width/2), (height/3 + 100 ));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("a new", (width/2), (height/3 + 200));
  fill(0);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("member", (width/2), (height/3 + 300));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  text("Hello!", (width/2), (100));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  textSize(60);
  text("Do you want to let someone", (width/2), (200));
  fill(255);
  textAlign(CENTER, BOTTOM);
  line(0, 120, width, 120);
  textSize(60);
  text("have access to your house?", (width/2), (300));
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(60);
  line(0, 120, width, 120);
  text("First you have to pair their device", (width/2), (400));
  fill(255);
  textAlign(CENTER, BOTTOM);
  textSize(60);
  line(0, 120, width, 120);
  text("to the aplication!", (width/2), (500));
  
}
// ustawienia strona 5
void SiteUstawienia() {
  background(xb, yb, zb);
  dolnyPasek();
  image(ustawienia_po_photo, 4*width/5, 2050, width/5, width/5);
  textSize(60);
  fill(xc, yc, zc);
  textAlign(CENTER, CENTER);
  text("Change to bright/ dark color theme", width/2,  (100));
  fill(0, 149, 255);
  rect((width/2-width/5), 200, width/5, height/6, 10);
  fill(xd, yd, zd);
  rect(width/2, 200, width/5, height/6, 10);
  // po kliknieciu zmiana koloru
  // bright
  if (mouseX > (width/2-width/5) && mouseX < (width/2) && mouseY > (200) && mouseY < (200 + height/6) ){
    xb = 0;
    yb = 149;
    zb = 255; 
    temp_otwarte = drzwi_zamkniete_photo;
    temp_zamkniete = drzwi_zamkniete_photo;
  }
  // dark
  if (mouseX > (width/2) && mouseX < (width/2+width/5) && mouseY > (200) && mouseY < (200 + height/6) ){
    xb = 13;
    yb = 32;
    zb = 140;
    temp_otwarte = drzwi_otwarte_photo_dark; 
    temp_zamkniete = drzwi_zamkniete_photo_dark;
  }
}

void SiteAddingNewMember() {
  background(xb, yb, zb);
  // tutaj zeby sie cofnac trzeba kliknac strzaleczke w lewym gornym rogu
  fill(xc, yc, zc);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Provide the number of the new user", (width/2), (100));
  fill(xc, yc, zc);
  rect(width/8, 150, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(60);
  text(firstText, width/8 + 20, 177, 3*width/4, 100);
  
  fill(xc, yc, zc);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Provide the name of the new user", (width/2), (500));
  fill(xc, yc, zc);
  rect(width/8, 550, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(60);
  text(secondText, width/8 + 20, 577, 3*width/4, 100);
  
  fill(xc, yc, zc);
  textSize(50);
  textAlign(CENTER, CENTER);  
  text("Provide the surname of the new user", (width/2), (900));
  fill(xc, yc, zc);
  rect(width/8, 950, 3*width/4, 100, 10);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(60);
  text(thirdText, width/8 + 20, 977, 3*width/4, 100);

  // rysowanie strzałeczki with geometric shapes
  fill(xp, yp, zp);
  rect(30, 50, 50, 10, 0);
  triangle(60, 0, 60, 50, 100, 0);
}

void keyPressed() {
  if (key != CODED)                                       
  {
    //tagStatus = "Write URL, then press ENTER to transmit";
    switch(tempText)
    {
    case 1:
      firstText += key;
      break;
    case 2:
      secondText += key;
      break;    
    case 3:
      thirdText += key;
      break;
    default:
      break;
    }
    
    
  }
   if (keyCode == 67)                               // 10
  {
    switch(tempText)
    {
    case 1:
      firstText = firstText.substring(0, firstText.length()-1);      
      break;
    case 2:
      secondText = secondText.substring(0, secondText.length()-1);
      break;    
    case 3:
      thirdText = thirdText.substring(0, thirdText.length()-1);
      break;
    default:
      break;
    }
  }
}

void oscEvent(OscMessage theOscMessage)
{
  otwarcie_drzwi = theOscMessage.get(0).intValue();
}