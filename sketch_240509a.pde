PImage cat;

float catSizeX = 150.0;
float catSizeY = 150.0;
float catSpeed = 4.0;
PVector catPos = new PVector( -150, 350 ); 
PVector catDir = new PVector( 1, 0 );
int catRotateCount = 0;
int catRotateCountMax = 50;

boolean viewSuccess = false;
int viewSuccessCount = 0;

void setup()
{
    size(700, 700);
    cat = loadImage("cat.png");
}

void draw()
{
    background( 255 );
    image( cat, catPos.x, catPos.y,catSizeX,catSizeY );
    
    //一定時間経ったら方向転換
    if( catRotateCount > catRotateCountMax ){
      rotateCat();
      catRotateCount = 0;
    }

    // 画面外に出たら方向転換
    if( catPos.x < -catSizeX || catPos.x > 700
        || catPos.y < -catSizeY || catPos.y > 700 ){
        rotateCat();
        catRotateCount = 0;
     }
    
    catPos.add( catDir );
    catRotateCount++;
    
    if( viewSuccess ){
      fill( 100, 255, 100 );
      textSize( 50 ); 
      text( "Gotcha!", 250, 250 );
      if( viewSuccessCount < 25 ){
          viewSuccessCount++;
      }
      else{
          viewSuccessCount = 0;
          viewSuccess = false;
          initializeCat();
      }
    }
}

void mousePressed()
{
  print( "mouse pressed\n" );
  print( mouseX + ", " + mouseY );
  if( catPos.x <= mouseX && mouseX <= catPos.x + catSizeX
      && catPos.y <= mouseY && mouseY <= catPos.y + catSizeY ){
       viewSuccess = true;
  }
}

void rotateCat()
{
  catDir.rotate( random( 6 ) - 3 );
  catDir.normalize();
  catDir.mult( catSpeed );
}

void initializeCat()
{
  catPos.set( random( 700 ), random( 700 ) );
  catRotateCount = 0;
  rotateCat();
}
