import processing.pdf.*;

void setup(){
  String[] lines = loadStrings("datedatedate.txt");  // 카카오톡 데이터를 입력
  String[] date = new String[lines.length];
  String[] who = new String[lines.length];
  String[] context = new String[lines.length];
  String[] realdate = new String[lines.length];
  int[] pointk = new int[lines.length];

  String search = ", ";
  String search2 = " : ";
  String search3 = "년";
  
  String letsfindthis = "사랑해";   /* 찾을 단어들을 저장하는 과정 */
  String letsfindthis2 = "미안";
  String letsfindthis3 = "오빠";
 // String letsfindthis4 = "야옹";  /* 처음에 6개까지 했다가 최종적으로는 1개를 빼고 5개만 출력함*/
  String letsfindthis5 = "효연";
  String letsfindthis6 = "내꾸";
  String letsfindthis7 = "니꾸";
  
  
  PShape[] b = new PShape[6];           // 도형들을 입력하는 과정
  b[0] = loadShape("iloveyou2.svg");
  b[1] = loadShape("mine2.svg");
  b[2] = loadShape("punch2-gray.svg");
//  b[3] = loadShape("sorry2-beige.svg");
  b[4] = loadShape("sleepy2-purple.svg");
  b[5] = loadShape("yours2-black.svg");
  
  int countdate = 0;
  
  size(680,1020,PDF,"pattern-ribbon");
  background(255,253,250);


  // 데이터 불러와서 쪼개기
 for(int i=0 ; i < lines.length ; i ++ )
 {  
 
  int index = lines[i].indexOf(search); 
  int index2 = lines[i].indexOf(search2);
  
    if( 24>index && index>0 && 35>index2 && index2>20 ) {
  
      String A = lines[i];
      String[] p = split(A, " : ");
      String B = p[0];
      String[] q = split(B, ",");
    
      date[i] = q[0];
      who[i] = q[1];
      context[i]="";
      for(int j=1;j<p.length;j++) context[i] += p[j];
      
      A = date[i];
      if(A.indexOf("오전")>0) { String[] n = split(A, " 오전");
                               realdate[i] = n[0]; }
      if(A.indexOf("오후")>0) { String[] n = split(A, " 오후");
                               realdate[i] = n[0]; }
  
      }
 }

// 날짜가 몇개인지 세기 
 for(int i=0 ; i < lines.length; i ++ )
 {  
    int index = lines[i].indexOf(search3); 
    if( index>0 && index < 10 ) {
      
     countdate++ ; 
     pointk[countdate] = i ;
     
     if(countdate == 936 ) { println(i); }
     }
   
  }
  
  println(countdate);
  
   
   
  // 날짜 수의 가로 세로 구하기 
   
  int dateX = 0 ;
  int dateY = 0 ;
  /*
  for( int s = int(sqrt(countdate))-1 ; s > 0 ; s = s-1 )
      { 
        if( countdate % s == 0 ) {
               dateY = s ;
               dateX = int(countdate / s) ;
               break;
        }
      }
  */  // 여기서도 소스코드가 가로, 세로 갯수를 구해주지만, 편의상 임의로 제가 지정을 했어요. 
  dateX = 3 ;
  dateY = 120;
  println(dateX) ;
  println(dateY) ;
  
    
// 도형 그리기

int spanx = int((width-100) / dateX) ;

println(spanx);
int spany = int(height/ dateY) ; 

int startingpointx ; 
int x = 1 ;
int y = 0 ; 
float timerate ;
int hour=1;
int plusx;
int min;
int beforehour = 0;
int beforemin = 0;

String[][] anni = {{"2014. 4. 17.","2014. 4. 18.","2014. 4. 19."}, {"2014. 7. 26.","2014. 7. 27.","2014. 7. 28."},
                   {"2014. 11. 3.","2014. 11. 4.","2014. 11. 5."}, {"2015. 2. 11.","2015. 2. 12.","2015. 2. 13."},
                   {"2015. 5. 22.","2015. 5. 23.","2015. 5. 24."}, {"2015. 8. 30.","2015. 8. 31.","2015. 9. 1."},
                   {"2015. 12. 8.","2015. 12. 9.","2015. 12. 10."}, {"2016. 3. 17.","2016. 3. 18.","2016. 3. 19."},
                   {"2016. 6. 25.","2016. 6. 26.","2016. 6. 27."}, {"2016. 10. 3.","2016. 10. 4.","2016. 10. 5."}}; /*이거는 특정 기념일들을 입력하는 과정
                   1200일 중에서 100일단위로 해서 12개의 날짜만 출력하기로 함 */

for(int i=0; i< anni.length; i++)
{
     y = y +94;
    
     for( int m = -1 ; m<=1 ; m++) //한줄에 3개씩이라서 -1, 0, 1이렇게 3번 for문 돌림
     {  
           x = (m+1) * spanx ;
            
           colorMode(RGB);
           strokeWeight(8); stroke(255,226,194); line(x,y,x+spanx,y); // 노란색 직선 그리는 코드 
           stroke(19,51,183); strokeWeight(4);
           line(x+5,y+10,x-5,y-10); line(x-5,y+10,x+5,y-10); // 파란색 X선 왼쪽에 그리는 코드
           if(m==1) { line(x+spanx-5,y+10,x+spanx+5,y-10); line(x+spanx+5,y+10,x+spanx-5,y-10); }// 맨 오른쪽 파란 X선 그리는 코드       
           
           for(int k=0 ; k < lines.length ; k++ ) // 날짜 안으로 
           {
               if( ! ( realdate[k] != null && realdate[k].equals(anni[i][m+1]) )) continue;
                       
                 if( context[k] != null )
                 {    //메세지 내용으로 
          
                     String[] p = split(date[k], ":"); //'오전 11:22' 형식으로 저장되있던 단어를 '오전 11' 와 '22' 로 쪼개서 p[0], p[1]에 저장 
                      
                     if ( p.length >= 2 ) 
                     {
                       min = Integer.parseInt(p[1]);              
                        
                       if(p[0].indexOf("오전") > 0) { String[] r = split(p[0],"오전 "); hour = Integer.parseInt(r[1]); } //오전 오후로 상황을 나누어서, hour에 
                       if(p[0].indexOf("오후") > 0) { String[] r = split(p[0],"오후 "); hour = Integer.parseInt(r[1]);  // 시를 저장 
                                                        if(hour <12) { hour = hour+ 12;}
                                                       }
          
                       timerate = float(hour*60 + min) / float(1440) ; // 메세지를 보낸 시간의 하루(24시간)에서의 백분율 구하기
                       strokeWeight(2); stroke(50); 
                       line( x+timerate*spanx , y-5,  x+timerate*spanx , y+5); // 모든 메세지는 직선으로 일단 그려짐. 
                                          
                       int index3 = context[k].indexOf(letsfindthis);      
                       int index4 = context[k].indexOf(letsfindthis2);
                       int index5 = context[k].indexOf(letsfindthis3);
                   //  int index6 = context[k].indexOf(letsfindthis4);
                       int index7 = context[k].indexOf(letsfindthis5);               // 5개의 단어를 찾아서, 해당 도형을 그리는 소스코드
                       int index8 = context[k].indexOf(letsfindthis6);
                       int index9 = context[k].indexOf(letsfindthis7);
                       if( index3 >= 0 ){ shape(b[0], x+timerate*spanx -20 , y-33,  40,66); }  
                       if( index4 >= 0 ){ shape(b[1], x+timerate*spanx -20 , y-33,  40,70); }  
                       if( index5 >= 0 ){ shape(b[2], x+timerate*spanx -20 , y-33,  40,70); }  
                   //  if( index6 >= 0 ){ shape(b[3], x+timerate*spanx -15 , y-30,  30,60); }
                       if( index7 >= 0 ){ shape(b[4], x+timerate*spanx -20 , y-33,  40,70); }  
                       if( index8 >= 0 ){ shape(b[5], x+timerate*spanx -20 , y-33,  40,70); }
                       if( index9 >= 0 ){ shape(b[5], x+timerate*spanx -20 , y-33,  40,70); }  
                         
          
                    }
                     else { println(date[k]);}
                }
           }
     }
}

 
}