uses ptcgraph;

const X_UP=0;
	Y_UP=0;
	X_DOWN=1366;
	Y_DOWN=700;
	COLOURS=128;
	LEFT=-20;
	RIGHT=20;
	UP=20;
	DOWN=-20;
	INFINITY=10e6;

var st_x, st_y, z_min, z_max:extended;

function f(x, y:extended):extended;
begin
	exit(sin(x)*sin(y));
end;

function min(t1, t2:extended):extended;
begin
	if t1<t2 then exit(t1)
		else exit(t2);
end;

function max(t1, t2:extended):extended;
begin
	if t1>t2 then exit(t1)
		else exit(t2);
end;

procedure init;
var i, j:extended;
begin
	st_x:=(RIGHT-LEFT)/(X_DOWN-X_UP);
	st_y:=(UP-DOWN)/(Y_DOWN-Y_UP);
	z_max:=f(LEFT, DOWN);
	z_min:=z_max;
	i:=LEFT;
	while i<=RIGHT do begin
		j:=DOWN;
		while j<=UP do begin
			//writeln(f(i, j):0:6);
			z_max:=max(z_max, f(i, j));
			z_min:=min(z_min, f(i, j));
			j:=j+st_y;
			end;
		i:=i+st_x;
		end;
end;

function getColour(z:extended):longint;
begin
	exit(round((z-z_min)/(z_max-z_min)*COLOURS));
end;

function getDisplayX(t:extended):integer;
begin
	exit(round(X_UP+(t-LEFT)/(RIGHT-LEFT)*(X_DOWN-X_UP)));
end;

function getDisplayY(t:extended):integer;
begin
	exit(round(Y_DOWN-(t-DOWN)/(UP-DOWN)*(Y_DOWN-Y_UP)));
end;

procedure paint;
var i, j:extended;
	GraphDriver, GraphMode:smallint;
	k:longint;
begin
	DetectGraph(GraphDriver, GraphMode);
	InitGraph(GraphDriver, GraphMode, '');
	for k:=0 to 255 do
		setRGBPalette(k, k, k, k);
	i:=LEFT;
	while i<=RIGHT do begin
		j:=DOWN;
		while j<=UP do begin
			//writeln(getDisplayX(i), ' ', getDisplayY(j), ' ', getColour(f(i, j)));
			putpixel(getDisplayX(i), getDisplayY(j), getColour(f(i, j)));
			j:=j+st_y;
			end;
	        i:=i+st_x;
		end;
end;

begin
	init;
	writeln('STEP: ', st_x:0:6, ' ', st_y:0:6);
	writeln('Z: ', z_max:0:6, ' ', z_min:0:6);
	paint;
	readln;
end.
