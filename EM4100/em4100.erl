-module(em4100).
-export([check_packet/1, check_row_parity/1, even_parity/1]).

check_packet(Packet) ->
		     <<Header:9, Data:54, Stop:1>> = <<Packet:64>>,
		     Header = 2#111111111,
		     Stop = 2#0,
		     check_row_parity(Data).

check_row_parity(Data) ->
		      <<
		      Row0:4, Ep0:1,
		      Row1:4, Ep1:1,
		      Row2:4, Ep2:1,
		      Row3:4, Ep3:1,
		      Row4:4, Ep4:1,
		      Row5:4, Ep5:1,
		      Row6:4, Ep6:1,
		      Row7:4, Ep7:1,
		      Row8:4, Ep8:1,
		      Row9:4, Ep9:1,
		      _:4>> = <<Data:54>>,
		      Ep0 = even_parity(Row0),
		      Ep1 = even_parity(Row1),
		      Ep2 = even_parity(Row2),
		      Ep3 = even_parity(Row3),
		      Ep4 = even_parity(Row4),
		      Ep5 = even_parity(Row5),
		      Ep6 = even_parity(Row6),
		      Ep7 = even_parity(Row7),
		      Ep8 = even_parity(Row8),
		      Ep9 = even_parity(Row9),
		      true.

even_parity(Row) ->
		 <<A:1, B:1, C:1, D:1>> = <<Row:4>>,
		 A bxor B bxor C bxor D.
