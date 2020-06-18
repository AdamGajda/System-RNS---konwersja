

module converter_tb();

reg [7:0] m1, m2, m3, test;
reg [7:0] x1, x2, x3;
wire [14:0] x;
integer i;


converter dut(m1,m2,m3,x1,x2,x3,x);

initial begin
m1=3;m2=5;m3=7;
test = 0;
end

initial begin
for(i = 0; i < 1001; i=i+1)begin
x1 = $urandom() % m1;
x2 = $urandom() % m2;
x3 = $urandom() % m3;
#10;

if(x % m1 == x1)begin
if(x % m2 == x2)begin
if(x % m3 != x3)begin
test = test + 1;
end
end else begin
test = test + 1;
end
end else begin
test = test + 1;
end

end
end


initial begin

$monitor("x1=%d,x2=%d,x3=%d,m1=%d,m2=%d,m3=%d,x=%d,liczba niepoprawnych wynikow=%d", x1, x2, x3,m1,m2,m3, x,test);
end

endmodule
