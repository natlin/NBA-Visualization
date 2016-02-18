void dropdown(int n) {
  /* request the selected item based on index n */
  println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));
  
  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
  
   CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
  
}

void keyPressed() {
  switch(key) {
    case('1'):
    /* make the ScrollableList behave like a ListBox */
    cp5.get(ScrollableList.class, "dropdown").setType(ControlP5.LIST);
    break;
    case('2'):
    /* make the ScrollableList behave like a DropdownList */
    cp5.get(ScrollableList.class, "dropdown").setType(ControlP5.DROPDOWN);
    break;
    case('3'):
    /*change content of the ScrollableList */
    List l = Arrays.asList("a-1", "b-1", "c-1", "d-1", "e-1", "f-1", "g-1", "h-1", "i-1", "j-1", "k-1");
    cp5.get(ScrollableList.class, "dropdown").setItems(l);
    break;
    case('4'):
    /* remove an item from the ScrollableList */
    cp5.get(ScrollableList.class, "dropdown").removeItem("k-1");
    break;
    case('5'):
    /* clear the ScrollableList */
    cp5.get(ScrollableList.class, "dropdown").clear();
    break;
  }
}