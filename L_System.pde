// Coding Train
// Ported to processing by Max (https://github.com/TheLastDestroyer)
// Origional JS by Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/E1B4UoSQMFw

// variables: A B
// axiom: A
// rules: (A → AB), (B → A)

float angle,cangle;
String axiom = "X";
String sentence = axiom;
float flen,slen;
float cflen,cslen;
color bgcolor = 255, linecolor = 0;
Rule[] rules;


void setup(){
  size(400,400);
  
  flen = height * 0.618033988749855 * 0.618033988749855 * 0.618033988749855 * 0.618033988749855; 
  slen = flen * 0.618033988749855;
  
  rules = new Rule[3];
  rules[0] = new Rule('X', "F+[[L]-L]-F[-FX]+X");
  rules[1] = new Rule('F', "FS");
  rules[2] = new Rule('L', "");
  
  angle = radians(25);
  background(bgcolor);
  println(axiom);
  turtle();
}

void draw(){
}


void mouseClicked(){
  println("click");
  generate();
  
  println(sentence);
  turtle();
}


class Rule {
  char a;
  String b;
  Rule(char _a, String _b){
    a = _a;
    b = _b;
  }
}

void generate(){
  //angle *= 0.618033988749855;
  flen *= 0.718033988749855;
  slen *= 0.718033988749855;
  
  String next_sentence = "";
  for (int i = 0; i < sentence.length(); i++){
    char current = sentence.charAt(i);
    boolean found = false;
    for (int j = 0; j < rules.length; j++){
      if (current == rules[j].a){
        found = true;
        next_sentence += rules[j].b;
        break;
      }
    }
    if (!found){
      next_sentence += current;
    }
  }
  sentence = next_sentence;

}


void turtle(){
  background(bgcolor);
  resetMatrix(); 
  translate(width/2, height);
  stroke(linecolor);
  strokeWeight(5);
  
  cangle = angle;
  cflen = flen;
  cslen = slen;
  
  for (int i = 0; i < sentence.length(); i++) {
    char current = sentence.charAt(i);

    if (current == 'F') {
      line(0, 0, 0, -cflen);
      translate(0, -cflen);
    } else if (current == 'S') {
      line(0, 0, 0, -cslen);
      translate(0, -cslen);
    } else if (current == 'L') {
      line(0, 0, 0, -cslen*1.618033988749855);
      translate(0, -cslen*1.618033988749855);
    } else if (current == '+') {
      rotate(angle);
    } else if (current == '-') {
      rotate(-angle);
    } else if (current == '[') {
      pushMatrix();
      //cangle *= 0.618033988749855;
      cflen *= 0.918033988749855;
      cslen *= 0.918033988749855;
    } else if (current == ']') {
      popMatrix();
      //cangle /= 0.618033988749855;
      cflen /= 0.918033988749855;
      cslen /= 0.918033988749855;
    }
    
    
    
  }
}
