import processing.pdf.*; //pdf로 저장하기 위해서 기능을 import함 

void setup(){
  String[] lines = loadStrings("kakaotalkchatlog.txt"); // 카카오톡 데이터를 입력
  String[] date = new String[lines.length];             
  String[] who = new String[lines.length];
  String[] context = new String[lines.length];
  int[] pointk = new int[lines.length];

  String letsfindthis = "사랑해"; // 찾을 메세지 '사랑해'를 입력
  
  PShape [] design = new PShape[1];
  design[0] = loadShape("heart.svg"); // 사용할 디자인 요소 '하트모양'을 입력
  
  String search = ", ";
  String search2 = " : ";
  String search3 = "년";
  
  int countdate = 0;
  
  size(1134,1418,PDF,"pattern"); //pattern이라는 이름으로 pdf로 저장됨. 
  background(0);

  // 저장된 한줄들을 쪼개서 날짜를 date[i]에 말한 사람을 who[i]에 내용을 context[i]에 저장
 for(int i=0 ; i < lines.length ; i ++ )
 {  
  int index = lines[i].indexOf(search); // 한 줄에서 search( ,)가 시작되는 지점을 index에 저장하라.
  int index2 = lines[i].indexOf(search2); // 마찬가지로 search2(:)가 시작되는 지점을 index 2에 저장하라. 
  
    if( 24>index && index>0 && 35>index2 && index2>20) { //쪼개서 저장하는 if문
  
      String A = lines[i];
      String[] p = split(A, " : ");
      String B = p[0];
      String[] q = split(B, ",");
    
      date[i] = q[0];
      who[i] = q[1];
      context[i]="";
      for(int j=1;j<p.length;j++) context[i] += p[j];
  
      }
 }

// 날짜가 몇개인지 세기 
 for(int i=0 ; i < lines.length; i ++ )
 {  
    int index = lines[i].indexOf(search3); 
    if( index>0 && index < 10 ) {
     
     countdate++ ; 
     pointk[countdate] = i ;
           
     }
  }
  
  println(countdate);
  

      
  // 날짜 수의 가로 세로 구하기, 가로로 몇일을 배열하고 세로로 몇줄을 배열할지 정하는 단계
  int dateX = 0 ;
  int dateY = 0 ;
 
  for( int s = int(sqrt(countdate))-1 ; s > 0 ; s = s-1 )
      { 
        if( countdate % s == 0 ) {
               dateY = s ;
               dateX = int(countdate / s) ;
               break;
        }
      }
      
  println(dateX) ;
  println(dateY) ;

  // 이렇게 하면 원래는 가장 정사각형에 가깝게 가로 40개 세로 30개로 구해줌. 


dateX = 16;   // 그러나 이 아이템은 셔츠로, 제가 임의로 16개로 지정했습니다. 
int spanx = int((width-20) / dateX) ; // 한 날짜에 해당하는 가로길이를 구하는 식

int startingpointx ; 
int x = 10 ;
int y = 10 ; 
float timerate ;
int hour=1;
int plusx;            
int min;
int index3;
int s=0;;
int countheart=0;
stroke(255);

  /* 여기서 부터 1일부터 모든 메세지를 확인하면서 날짜선을 그리고, 하트를 찍는 과정*/

  for(int i=150; i<= countdate; i++) { /* 데이터를 돌려보니 1일부터 150일까지는 하트가 생기지 않아서, 
                                         앞의 날짜를 짜르고 150일부터 하트 찍기 시작 */
                                      // 저는 발표때문에 조정한거고 원래는는 i=1 부터 시작, 그러면 1일부터 countdate(아까 카운트한 날짜의 갯수)만큼 for문을 돌림
    x = s * spanx; 

    strokeWeight(1.5);
    line(x-3,y-3,x+3,y+3);  // 날짜선을 그리는 식, /
    line(x-3,y+3,x+3,y-3);  //                   X
    line(x,y,x+spanx,y);    //                   X-----
    
    for(int k=pointk[i] ; k <= pointk[i+1] ; k++ ) { // 날짜 안으로 
      
          if( context[k] != null ) { index3 = context[k].indexOf(letsfindthis);  // context[k]에서(메세지내용) letsfindthis(사랑해)가 시작되는 위치(index)를 index3에 저장하라.        
          if( index3 >= 0 ){   // index가 0보다 클때 즉, 찾는 단어가 있었을 때

              String[] p = split(date[k], ":"); // p배열에 date[k]에서 ':'를 기준으로 쪼개서 저장하는데, 이러면 p[0]에 메시지의 시, p[1]에 메세지의 분이 저장됨. 
              
              if ( p.length >= 2 ) {
                min = Integer.parseInt(p[1]); // 메세지를 보낸 시간의 분(p[1])을 min이라는 변수에 저장              
                
                // 다음은 메세지를 보낸 시를 hour라는 변수에 저장하는 과정
                if(p[0].indexOf("오전") > 0) { String[] r = split(p[0],"오전 "); 
                                              plusx = 0 ;
                                              hour = Integer.parseInt(r[1]); }
                if(p[0].indexOf("오후") > 0) { String[] r = split(p[0],"오후 ");
                                              plusx = 12*60; 
                                              hour = Integer.parseInt(r[1]);}              
                              
                timerate = float(hour*60 + min) / float(1440) ; // 메세지를 보낸 시간의 하루(24시간)에서의 백분율 구하기
                shape( design[0], x + int(timerate*spanx)-7 , y-7,14,14); // 백분율을 활용해서 하트도형을 해당 좌표에 그리기
              }     
            }
          }
      }
      
      x++; // 날짜 하루가 끝났으니 x++한다. 
      s = s + 1 ; // 날짜 하루가 끝났으니 s에도 s+1한다. 
      if ( s%(dateX) == 0 && s > 1 ) {  // 만약에 s를 dateX(아까 16을 저장해둠, 날짜를 배열할 가로 갯수)로 딱 나눠 떨어지면 -> 즉 S가 16의 배수일때
           line(x+spanx-3,y-3,x+spanx+3,y+3); line(x+spanx-3,y+3,x+spanx+3,y-3); //패턴에서 맨 오른쪽 엑스모양을 그리고
           s = 0 ; y = y + 22; /* S는 0이되고 Y에는 +22를 해서 다음줄로 이동한다.*/ }     
      
      if( y > height ) { println(i); rect(x,y,10,10);}
      
  }

 println(countheart); //이건 그냥 체크용, 1200일 까지 잘 가는지 
 
}