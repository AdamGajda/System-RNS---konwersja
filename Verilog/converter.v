module converter(m1, m2, m3, x1, x2, x3, x);
input [7:0] m1, m2, m3;
input [7:0] x1, x2, x3;
output wire [14:0] x;

function [14:0] mul_inv;
input [14:0] a, b;
reg signed [14:0] u, w, x, z, q;
begin
	a = b - a;
  u = 1; w = a;
  x = 0; z = b;
  while( w )begin
    if( w < z )begin
      q = u; u = x; x = q;
      q = w; w = z; z = q;
    end
    q = w / z;
    u = u - q * x;
    w = w - q * z;
  end
  if( z == 1 )begin
    if( x < 0 )begin
	x = x + b;
	end
    mul_inv = x;
  end
end
endfunction

wire [7:0] M, M1, M2, M3;
wire [14:0] k1, k2, k3;
wire [7:0] SQ, D, S;

assign M = m1 * m2 * m3;

assign M1 = M / m1;
assign M2 = M / m2;
assign M3 = M / m3;

assign SQ = M1 + M2 + M3;

assign k1 = mul_inv(m1, SQ);
assign k2 = mul_inv(m2, SQ);
assign k3 = mul_inv(m3, SQ);

assign S = x1*M1 + x2*M2 + x3 * M3;



assign D = (k1*x1 + k2*x2 + k3*x3) % SQ;

assign x = (M * D + S) / SQ;

endmodule
