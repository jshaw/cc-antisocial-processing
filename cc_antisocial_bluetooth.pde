import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
boolean firstContact = false;

void setup(){
  println(Serial.list()); 
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  //change the 0 to a 1 or 2 etc. to match your port
  String portName = Serial.list()[2];
  //myPort = new Serial(this, portName, 38400);
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n'); 
}

void draw(){
 // If data is available,
 if ( myPort.available() > 0) {
    
   // read it and store it in val
   val = myPort.readStringUntil('\n');
 } 
 println(val); //print it out in the console
 
 if (keyPressed) {
   if (keyCode == UP) {
     myPort.write('u');         
     println("u"); 
   } else if (keyCode == DOWN) {
     myPort.write('d');         
     println("d"); 
   } else if (keyCode == LEFT){
     myPort.write('l');         
     println("l"); 
   } else if (keyCode == RIGHT){
     myPort.write('r');         
     println("r"); 
   } else {
     myPort.write("'" + key + "'");         
     println(key);
   }
   myPort.write("");         
   println("");
 }
  
 //if (mousePressed == true) {         
 //  //send a 1
 //  myPort.write('1');         
 //  println("1");   
 //} else {
 //  //send a 0
 //  myPort.write('0');
 //}   
}

void mouseReleased() {
  myPort.write('1');         
  println("1"); 
}


//void keyReleased() {
//  if (value == 0) {
//    value = 255;
//  } else {
//    value = 0;
//  }
//}

void serialEvent( Serial myPort) {
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  //make sure our data isn't empty before continuing
  if (val != null) {
    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);
    println(val);

    //look for our 'A' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) {
      if (val.equals("A")) {
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    } else {
      //if we've already established contact, keep getting and parsing data
      //println(val);

      //if (mousePressed == true) {
      //  //if we clicked in the window
      //  myPort.write('1');        //send a 1
      //  println("1");
      //}

      //// when you've parsed the data you have, ask for more:
      //myPort.write("A");
    }
  }
}