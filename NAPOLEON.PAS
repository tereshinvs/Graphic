uses crt, graph;

const AstX=100;
      AstY=100;
      BstX=200;
      BstY=100;
      CstX=200;
      CstY=200;
      trColour=14;
      trColour1=13;
      txColour=12;
      trWidth=2;
      medColour=10;

type TPoint=record x, y:real;
                   end;
     TEquation=record a, b, c:real;
                      end;

var med, pnt, pnt1:array[1..3] of TPoint;
    i, curPoint, d, m:integer;
    ssres, gvres:TPoint;
    l12, l23, l31:real;
    sh:string;

procedure solveSystem(t1, t2:TEquation);
var det, detx, dety:real;
begin
     det:=t1.a*t2.b-t1.b*t2.a;
     detx:=t1.c*t2.b-t1.b*t2.c;
     dety:=t1.a*t2.c-t1.c*t2.a;
     ssres.x:=detx/det;
     ssres.y:=dety/det;
end;

function getLength(p1, p2:TPoint):real;
begin
     getLength:=sqrt(sqr(p1.x-p2.x)+sqr(p1.y-p2.y));
end;

procedure getVert(pst, pkon:TPoint);
var v:TPoint;
    l:real;
    eq1, eq2:TEquation;
begin
     v.x:=pkon.x-pst.x;
     v.y:=pkon.y-pst.y;
     l:=getLength(pst, pkon);
     eq1.a:=v.x;
     eq1.b:=v.y;
     eq1.c:=l*l*cos(-pi/3);
     eq2.a:=-v.y;
     eq2.b:=v.x;
     eq2.c:=l*l*sin(-pi/3);
     solveSystem(eq1, eq2);
     gvres.x:=ssres.x+pst.x;
     gvres.y:=ssres.y+pst.y;
end;

procedure paint;
begin
     clearDevice;
     setcolor(trColour);
     setlinestyle(0, 0, trWidth);
     line(round(pnt[1].x), round(pnt[1].y), round(pnt[2].x), round(pnt[2].y));
     line(round(pnt[2].x), round(pnt[2].y), round(pnt[3].x), round(pnt[3].y));
     line(round(pnt[3].x), round(pnt[3].y), round(pnt[1].x), round(pnt[1].y));
     setcolor(trColour1);
     line(round(pnt1[3].x), round(pnt1[3].y), round(pnt[1].x), round(pnt[1].y));
     line(round(pnt1[3].x), round(pnt1[3].y), round(pnt[2].x), round(pnt[2].y));
     line(round(pnt1[2].x), round(pnt1[2].y), round(pnt[1].x), round(pnt[1].y));
     line(round(pnt1[2].x), round(pnt1[2].y), round(pnt[3].x), round(pnt[3].y));
     line(round(pnt1[1].x), round(pnt1[1].y), round(pnt[3].x), round(pnt[3].y));
     line(round(pnt1[1].x), round(pnt1[1].y), round(pnt[2].x), round(pnt[2].y));
     setcolor(medColour);
     line(round(med[1].x), round(med[1].y), round(med[2].x), round(med[2].y));
     line(round(med[2].x), round(med[2].y), round(med[3].x), round(med[3].y));
     line(round(med[3].x), round(med[3].y), round(med[1].x), round(med[1].y));
     setcolor(txColour);
     outtextxy(round(pnt[1].x), round(pnt[1].y), 'A');
     outtextxy(round(pnt[2].x), round(pnt[2].y), 'B');
     outtextxy(round(pnt[3].x), round(pnt[3].y), 'C');
     outtextxy(round(pnt1[1].x), round(pnt1[1].y), 'A''');
     outtextxy(round(pnt1[2].x), round(pnt1[2].y), 'B''');
     outtextxy(round(pnt1[3].x), round(pnt1[3].y), 'C''');
     outtextxy(round(med[1].x), round(med[1].y), 'A''''');
     outtextxy(round(med[2].x), round(med[2].y), 'B''''');
     outtextxy(round(med[3].x), round(med[3].y), 'C''''');
     str(l12:0:3, sh);
     outtextxy(round((med[1].x+med[2].x)/2), round((med[1].y+med[2].y)/2), sh);
     str(l23:0:3, sh);
     outtextxy(round((med[2].x+med[3].x)/2), round((med[2].y+med[3].y)/2), sh);
     str(l31:0:3, sh);
     outtextxy(round((med[3].x+med[1].x)/2), round((med[3].y+med[1].y)/2), sh);
end;

procedure control(tc:char);
begin
     case tc of
          'a': curPoint:=1;
          'b': curPoint:=2;
          'c': curPoint:=3;
          'd': pnt[curPoint].y:=pnt[curPoint].y+1;
          'u': pnt[curPoint].y:=pnt[curPoint].y-1;
          'l': pnt[curPoint].x:=pnt[curPoint].x-1;
          'r': pnt[curPoint].x:=pnt[curPoint].x+1;
          #27: begin
               closegraph;
               halt;
               end;
          end;
end;

begin
     initgraph(d, m, '');
     pnt[1].x:=AstX; pnt[1].y:=AstY;
     pnt[2].x:=BstX; pnt[2].y:=BstY;
     pnt[3].x:=CstX; pnt[3].y:=CstY;
     curPoint:=1;
     while true do begin
           getVert(pnt[1], pnt[2]);
           pnt1[3]:=gvres;
           getVert(pnt[2], pnt[3]);
           pnt1[1]:=gvres;
           getVert(pnt[3], pnt[1]);
           pnt1[2]:=gvres;
           med[3].x:=(pnt[1].x+pnt[2].x+pnt1[3].x)/3;
           med[3].y:=(pnt[1].y+pnt[2].y+pnt1[3].y)/3;
           med[2].x:=(pnt[3].x+pnt[1].x+pnt1[2].x)/3;
           med[2].y:=(pnt[3].y+pnt[1].y+pnt1[2].y)/3;
           med[1].x:=(pnt[2].x+pnt[3].x+pnt1[1].x)/3;
           med[1].y:=(pnt[2].y+pnt[3].y+pnt1[1].y)/3;
           l12:=getLength(med[1], med[2]);
           l23:=getLength(med[2], med[3]);
           l31:=getLength(med[3], med[1]);
           paint;
           control(readkey);
           end;
end.