/*public void play(/*int theValue*//*) {
  println("hi");
  //println("a button event: "+theValue); //theValue is set when declaring the button
  //c1 = c2;
  //c2 = color(0,0,0);
  //isPlaying = !isPlaying;
  println("ison?:" + cp5.get(Button.class, "play").isActive());
}*/

public void nextEvent(int theValue) {
  if(gameid != 0){
    println("Move to Event + " + theValue); //the Value is set by setValue or defaults to 1
    loadOneEvent();
  }
  
  
}

void mouseReleased(){
  if(cp5.get(Button.class, "play").isOn()){
    isPlaying = false;
  }
  else{
    isPlaying = true;
  }
}