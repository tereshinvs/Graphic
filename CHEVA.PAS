uses crt, graph;

const AstX=100; AstY=100;
      BstX=200; BstY=200;
      CstX=200; CstY=100;
      OstX=150; OstY=120;
      txPosX=100; txPosY=400;
      trColour=14;
      pColour=4;
      txColour=10;
      chColour=3;

type TPoint=record x, y:real;
                   end;
     TEquation=record a, b, c:real;
                      end;

var tr, ch:array[0..3] of TPoint;
    curPoint, d, m:integer;
    ssres:TPoint;
    geqres:TEquation;
    l1, l2, l3, l4, l5, l6:real;
    sh, s1, s2, s3, s4, s5, s6:string;

procedure solveSystem(eq1, eq2:TEquation);
var det, detx, dety:real;
begin
     det:=eq1.a*eq2.b-eq1.b*eq2.a;
     detx:=eq1.c*eq2.b-eq1.b*eq2.c;
     dety:=eq1.a*eq2.c-eq1.c*eq2.a;
     ssres.x:=detx/det;
     ssres.y:=dety/det;
end;

function inSegment(p, pa, pb:TPoint):boolean;
var va, vb:TPoint;
begin
     va.x:=p.x-pa.x; va.y:=p.y-pa.y;
     vb.x:=p.x-pb.x; vb.y:=p.y-pb.y;
     if va.x*vb.y-va.y*vb.x=0 then inSegment:=true
                              else inSegment:=false;
end;

function inside:boolean;
var v1, v2, v3:TPoint;
    sq, sr:real;
begin
     if (inSegment(tr[0], tr[1], tr[2])) or
        (inSegment(tr[0], tr[2], tr[3])) or
        (inSegment(tr[0], tr[3], tr[1])) then begin
                                              inside:=false;
                                              exit;
                                              end;
     v1.x:=tr[2].x-tr[1].x;
     v1.y:=tr[2].y-tr[1].y;
     v2.x:=tr[3].x-tr[1].x;
     v2.y:=tr[3].y-tr[1].y;
     sr:=abs(v1.x*v2.y-v1.y*v2.x);
     v1.x:=tr[0].x-tr[1].x;
     v1.y:=tr[0].y-tr[1].y;
     v2.x:=tr[0].x-tr[2].x;
     v2.y:=tr[0].y-tr[2].y;
     v3.x:=tr[0].x-tr[3].x;
     v3.y:=tr[0].y-tr[3].y;
     sq:=abs(v1.x*v2.y-v1.y*v2.x);
     sq:=sq+abs(v1.x*v3.y-v1.y*v3.x);
     sq:=sq+abs(v2.x*v3.y-v2.y*v3.x);
     if sq=sr then inside:=true
              else inside:=false;
end;

procedure control(tc:char);
var last:array[0..3] of TPoint;
    ci:integer;
begin
     for ci:=0 to 3 do
         last[ci]:=tr[ci];
     case tc of
          'o': curPoint:=0;
          'a': curPoint:=1;
          'b': curPoint:=2;
          'c': curPoint:=3;
          'd': begin
               tr[curPoint].y:=tr[curPoint].y+1;
               if not inside then tr[curPoint]:=last[curPoint];
               end;
          'u': begin
               tr[curPoint].y:=tr[curPoint].y-1;
               if not inside then tr[curPoint]:=last[curPoint];
               end;
          'l': begin
               tr[curPoint].x:=tr[curPoint].x-1;
               if not inside then tr[curPoint]:=last[curPoint];
               end;
          'r': begin
               tr[curPoint].x:=tr[curPoint].x+1;
               if not inside then tr[curPoint]:=last[curPoint];
               end;
          #27: begin
               closegraph;
               halt;
               end;
          end;
end;

procedure getEquation(p1, p2:TPoint);
begin
     geqres.a:=p2.y-p1.y;
     geqres.b:=p1.x-p2.x;
     geqres.c:=p1.x*(p2.y-p1.y)-p1.y*(p2.x-p1.x);
end;

procedure getChev(t1, t2, t3:integer);
var eq1, eq2:TEquation;
begin
     getEquation(tr[0], tr[t1]);
     eq1:=geqres;
     getEquation(tr[t2], tr[t3]);
     eq2:=geqres;
     solveSystem(eq1, eq2);
     ch[t1]:=ssres;
end;

procedure paint;
var pai:integer;
begin
     cleardevice;
     setcolor(trColour);
     line(round(tr[1].x), round(tr[1].y), round(tr[2].x), round(tr[2].y));
     line(round(tr[2].x), round(tr[2].y), round(tr[3].x), round(tr[3].y));
     line(round(tr[3].x), round(tr[3].y), round(tr[1].x), round(tr[1].y));
     setcolor(chColour);
     for pai:=1 to 3 do
         line(round(tr[pai].x), round(tr[pai].y), round(ch[pai].x), round(ch[pai].y));
     putpixel(round(tr[0].x), round(tr[0].y), pColour);
     setcolor(txColour);
     outtextxy(round(tr[0].x), round(tr[0].y), 'O');
     outtextxy(round(tr[1].x), round(tr[1].y), 'A');
     outtextxy(round(tr[2].x), round(tr[2].y), 'B');
     outtextxy(round(tr[3].x), round(tr[3].y), 'C');
     outtextxy(round(ch[1].x), round(ch[1].y), 'A''');
     outtextxy(round(ch[2].x), round(ch[2].y), 'B''');
     outtextxy(round(ch[3].x), round(ch[3].y), 'C''');
end;

function getLength(p1, p2:TPoint):real;
begin
     getLength:=sqrt(sqr(p1.x-p2.x)+sqr(p2.y-p1.y));
end;

begin
     initgraph(d, m, '');
     curPoint:=0;
     tr[0].x:=OstX; tr[0].y:=OstY;
     tr[1].x:=AstX; tr[1].y:=AstY;
     tr[2].x:=BstX; tr[2].y:=BstY;
     tr[3].x:=CstX; tr[3].y:=CstY;
     while true do begin
          getChev(1, 2, 3);
          getChev(2, 1, 3);
          getChev(3, 1, 2);
          l1:=getLength(tr[1], ch[3]);
          l2:=getLength(ch[3], tr[2]);
          l3:=getLength(tr[2], ch[1]);
          l4:=getLength(ch[1], tr[3]);
          l5:=getLength(tr[3], ch[2]);
          l6:=getLength(ch[2], tr[1]);
          str((l1*l3*l5)/(l2*l4*l6):0:3, sh);
          str(l1:0:3, s1); str(l2:0:3, s2);
          str(l3:0:3, s3); str(l4:0:3, s4);
          str(l5:0:3, s5); str(l6:0:3, s6);
          paint;
          outtextxy(txPosX, txPosY, '('+s1+'*'+s3+'*'+s5+')/('+s2+'*'+s4+'*'+s6+')='+sh);
          control(readkey);
          end;
     closegraph;
end.