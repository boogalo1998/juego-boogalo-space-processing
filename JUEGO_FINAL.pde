
PImage fondoImg = loadImage ( "https://i.ytimg.com/vi/dxp0amTfXWg/maxresdefault.jpg" );
PImage jugadorImg = loadImage ( "https://mamietop.files.wordpress.com/2018/09/c3b3vni.gif?w=128" );
PImage ostaculoImg = loadImage ( "https://i.pinimg.com/originals/b2/f3/02/b2f30283fe843fcccf12118afe2d9a57.png" );
PImage inicioImg = loadImage ( " https://1.bp.blogspot.com/-xnbBS--xnnQ/XjzKcTLXoSI/AAAAAAAAAJQ/grQnpraN68cMc9_BTxvnZca6SIlc4xNBQCLcBGAsYHQ/s1600/Mesa%2Bde%2Btrabajo%2B1-100.jpg" );
PFont font1;
int estado [];
float posX [];
float posY [];
import processing.serial.*;//Llama la información por puerto serial desde arduino

Serial port;
String leer;
int btn1;
int btn2;

int gamestate1 =  1 ; 
int gamestate2 =  1 ; 
int puntaje1  =  0, puntajeMaximo1 =  0 ;
int puntaje2  =  0, puntajeMaximo2 =  0 ;
int x =  - 100, y1, vy =  0 ;
int x1 =  - 100, y2, vy1 =  0 ;
int wx [] =  new  int [ 2], wy [] = new int [ 2];

void setup () { 
  size ( 600, 700 ); 
  fill( 100, 244, 255 );



  textSize ( 20 );  
  println(Serial.list());
   port= new Serial(this, Serial.list()[0], 9600);

  posX = new float[100];
  posY =new float[100];
  estado = new int [100];  

  for (int i=0; i<100; i++ ) {

    posX[i]=random(0, 500);
    posY[i]=random(0, 100);
    estado[i]=1;
  }
}

void draw() {  
  if (gamestate2 == 0 ) { 

    imageMode(CORNER);
    image(fondoImg, x, 0);
    image(fondoImg, x+fondoImg.width, 0); 
    x -= 1;
    vy += 1;
    y1 += vy; 
    x1 -= 1;
    vy1 += 1;
    y2 += vy1; 
    if (x == -1800) x = 0; 
    for (int i = 0; i < 2; i++) { 

      if (estado[i]==1) {
        image(ostaculoImg, posX[i], posY[i], 40, 40);
      }

      if (posX[i] < 0) { 

        posY[i] = (int)random(200, height -200);
        posX[i] = width ;
      }
      if (posX[i] == width/2) { 
        puntaje1++; 
        puntajeMaximo1 = max(puntaje1, puntajeMaximo1);
        puntaje2++; 
        puntajeMaximo2 = max(puntaje2, puntajeMaximo2);
      }
      if (y1>height||y1<0||(abs(width/2+posX[i])<25 && abs(y1+posY[i])>170)) { 

  
      }
      if (y2>height||y2<0||(abs(width/2+posX[i])<25 && abs(y2+posY[i])>170)) { 

    
      }
      posX[i] -= 6;
    }
    image(jugadorImg, width/2, y1);
    text(""+puntaje1, width/2-15, 100);
    image(jugadorImg, width/2, y2);
    text(""+puntaje2, width/2-15, 100);
  } // Hasta aquí
  else { 
    imageMode(CENTER);
    image(inicioImg, width/2, height/2);
    font1 = loadFont("BungeeInline-Regular-48.vlw");
    textFont(font1);
    textAlign(400, BOTTOM);
    textSize ( 30 );  
    text("Máxima puntuación 1: "+puntajeMaximo1, 100, 300);
    textAlign(400, TOP);
     text("Máxima puntuación 2: "+puntajeMaximo2, 100, 320);
  }
  
 if (0< port.available()) {
   
   leer =  port.readStringUntil('\n');
   
   if (leer!=null) {
   println(leer);
   
   String[] datosSensor = split(leer, 'T');
   
   if (datosSensor.length == 2)
   {
   println(datosSensor[0]);
   println(datosSensor[1]);
   btn1 = int(trim(datosSensor[0]));      
   btn2 = int(trim(datosSensor[1]));
   }
   }
   
    vy1 = -17; 
  if (gamestate2==1) { 

    wx[0] = 600;
    wy[0] = y2 = height/2;
    wx[1] = 900;
    wy[1] = 500;
    x1 = gamestate2 = puntaje1 = 0;
  }
   
   }
   
   
}

/*void mousePressed() { 
  vy1 = -17; 
   if (gamestate2==1) { 
   
   wx[0] = 600;
   wy[0] = y2 = height/2;
   wx[1] = 900;
   wy[1] = 500;
   x1 = gamestate2 = puntaje1 = 0;
   }

 
}*/

void keyPressed() {
  if (key=='w') {
    vy= -14;
    if (gamestate2==1) { 
      wx[0] = 600;
      wy[0] = y2 = height/2;
      wx[1] = 900;
      wy[1] = 500;
      x1 = gamestate2 = puntaje2 = 0;
    }
  }
}
