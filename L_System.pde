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
//float lenLevelScale=0.763932022500133;
float lenLevelScale=0.954101966249599;
float weightLevelScale=0.954101966249599;
float lenGenerationScale=0.618033988749855;
color bgColor = 255, lineColor = 0;
float lineWeight = 8, clineWeight;
Rule[] rules;


void setup(){
  size(400,400);
  
  flen = height * 0.618033988749855 * 0.618033988749855 * 0.618033988749855 * 0.618033988749855; 
  slen = flen * 0.618033988749855;
  
  rules = new Rule[3];
  rules[0] = new Rule('X', "F+[[LX]-L]-S[-FX]+X+F--X");
  rules[1] = new Rule('F', "FF");
  rules[2] = new Rule('L', "LS");
  
  angle = radians(25);
  background(bgColor);
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
  //angle *= lenGenerationScale;
  flen *= lenGenerationScale;
  slen *= lenGenerationScale;
  
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
  background(bgColor);
  resetMatrix(); 
  translate(width/2, height);
  stroke(lineColor);
  
  clineWeight = lineWeight;
  
  cangle = angle;
  cflen = flen;
  cslen = slen;
  
  for (int i = 0; i < sentence.length(); i++) {
    char current = sentence.charAt(i);

    strokeWeight(clineWeight);

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
      rotate(cangle);
    } else if (current == '-') {
      rotate(-cangle);
    } else if (current == '[') {
      pushMatrix();
      clineWeight *= weightLevelScale;
      cangle = radians(degrees(cangle)*lenLevelScale);
      cflen *= lenLevelScale;
      cslen *= lenLevelScale;
    } else if (current == ']') {
      popMatrix();
      clineWeight /= weightLevelScale;
      cangle = radians(degrees(cangle)/lenLevelScale);
      cflen /= lenLevelScale;
      cslen /= lenLevelScale;
    }
    
    
    
  }
}
