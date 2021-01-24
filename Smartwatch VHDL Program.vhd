library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Integration is
	port(clk,start,pause,rst: in bit;
	SelectLine:in bit_vector(1 downto 0);
	intime_H,intime_M,intime_S,intime_MIL,PulseDur:inout integer;
	Out_H,Out_M,Out_S,Out_Mils:out integer;
	TimerOut:out bit;
	RIAout:out bit);
end Integration;

architecture Behavioral of Integration is

shared variable H,M,S,mils: integer :=0;

begin
	intime_H<=0;
	intime_M<=0;
	intime_S<=5;
	intime_MIL<=500;
	process(clk)
		begin
		
		if (SelectLine="01") then
		if(rst='1')then
			H:=0;
			M:=0;
			S:=0;
			mils:=0;
		end if;
		
		if(start='1')then
			if (clk='1') then
			mils:=mils+1;
			end if;
			if (mils=1000) then
				S:=S+1;
				mils:=0;
			end if;
			if (S=60) then
				M:=M+1;
				S:=0;
				mils:=0;
			end if;
			if (M=60) then
				H:=H+1;
				M:=0;
				S:=0;
				mils:=0;
			end if;
		end if;
		
		if (H=intime_H and M=intime_M and S=intime_S and mils=intime_MIL) then
			TimerOut<='1';
			TimerOut<='0' after 1000 ms;
			H:=0;
			M:=0;
			S:=0;
			mils:=0;
		end if;
	end if;
	
	if (SelectLine="00") then
		if (pause='0') then
			if (clk='1') then
				mils:=mils+1;
			end if;
			if (mils=1000) then
				S:=S+1;
				mils:=0;
			end if;
			if (S=60) then
				M:=M+1;
				S:=0;
				mils:=0;
			end if;
			if (M=60) then
				H:=H+1;
				M:=0;
				S:=0;
				mils:=0;
			end if;
		end if;
		if (rst='1') then
			H:=0;
			M:=0;
			S:=0;
			mils:=0;
		end if;
		Out_H<=H;
		Out_M<=M;
		Out_S<=S;
		Out_Mils<=mils;
	end if;
	
	if (SelectLine="10") then

		if (clk='1') then
			mils:=mils+1;
		end if;
		if (mils=1000) then
			S:=S+1;
			mils:=0;
		end if;
		if (S=60) then
			M:=M+1;
			S:=0;
			mils:=0;
		end if;
		if (M=60) then
			H:=H+1;
			M:=0;
			S:=0;
			mils:=0;
		end if;
		if (H=intime_H and M=intime_M and S=intime_S and mils=intime_MIL) then
			RIAout <= '1';
			RIAout <= '0' after 1000 ms;
			H:=0;
			M:=0;
			S:=0;
			mils:=0;
		end if;	
	end if;
	end process;
	
	process(SelectLine)
	begin
		H:=0;
		M:=0;
		S:=0;
		mils:=0;
	end process;

end Behavioral;