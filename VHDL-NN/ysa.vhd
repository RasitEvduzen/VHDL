-- Kütüphaneler
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ysa is
     Port ( 
				y  : out  std_logic_vector(7 downto 0);  -- YSA OUTPUT 
            x  : in   std_logic_vector(7 downto 0)	  -- YSA İNPUT
			 );
end ysa;

architecture Behavioral of ysa is
	 -- Sabitler
	  CONSTANT clk_high                         : time := 5 ns;
	  CONSTANT clk_low                          : time := 5 ns;
	  CONSTANT clk_period                       : time := 10 ns;
	  CONSTANT clk_hold                         : time := 2 ns;
	  

	 -- YSA MODEL PARAMETRELERİ
    signal		Wg	:	STD_LOGIC_VECTOR (7 downto 0);	-- Wg => giriş ağırlığı
	 signal		Wc	:	STD_LOGIC_VECTOR (7 downto 0);	-- Wc => çıkış ağırlığı
	 signal		bg :	STD_LOGIC_VECTOR (7 downto 0);	-- bg => giriş bias
	 signal		bc	:	STD_LOGIC_VECTOR (7 downto 0);	-- bc => çıkış bias
	 
	 -- Komponentler
	 -- Exponential
	 	component exp1
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clk_en	: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	signal clk_en_exp1		:STD_LOGIC;
	signal data_exp1			:STD_LOGIC_VECTOR (31 DOWNTO 0);
	signal result_exp1		:STD_LOGIC_VECTOR (31 DOWNTO 0);
	-- Toplayıcı
		component add1
	PORT
		(
			aclr			 : IN STD_LOGIC ;
			clk_en		 : IN STD_LOGIC ;
			clock			 : IN STD_LOGIC ;
			dataa			 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			datab			 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			result		 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)	
		);
	end component;
	signal clk_en_add1		:std_logic;
	signal dataa_add1			:std_logic_vector(31 downto 0);
	signal datab_add1			:std_logic_vector(31 downto 0);
	signal result_add1		:std_logic_vector(31 downto 0);
	-- Çarpıcı
		component mul1
	PORT
		(
			aclr			 : IN STD_LOGIC ;
			clk_en		 : IN STD_LOGIC ;
			clock			 : IN STD_LOGIC ;
			dataa			 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			datab			 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			result		 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)	
		);
	end component;
	signal clk_en_mul1		:std_logic;
	signal dataa_mul1			:std_logic_vector(31 downto 0);
	signal datab_mul1			:std_logic_vector(31 downto 0);
	signal result_mul1		:std_logic_vector(31 downto 0);
	-- Bölücü 
		component div1
	PORT
		(
		aclr		: IN STD_LOGIC ;
		clk_en	: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)	
		);
	end component;
	signal clk_en_div1		:std_logic;
	signal dataa_div1			:std_logic_vector(31 downto 0);
	signal datab_div1			:std_logic_vector(31 downto 0);
	signal result_div1		:std_logic_vector(31 downto 0);	
	
	signal aclr		      :std_logic;
	signal clock	      :std_logic;
	signal rst	        :std_logic:='1';
	
	-- YSA stateleri
	type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8);
	signal	state				   :state_type;
	signal	state_next	 		:state_type;
	signal cnt					   :integer:=0;
	signal cnt_end			      :integer:=0;

	-- Giriş Sinyali X değeri
	--signal x           :std_logic_vector(15 downto 0):=x"0004";
	
	-- YSA SÜRECİN GERÇEKLENMESİ
  process(clock,rst,state)
	  begin 
	  
  end process;
	
	-- PORT MAP
	-- Toplayıcı
	add1_inst : add1 PORT MAP (
		aclr	    => aclr_sig,
		clk_en	 => clk_en_sig,
		clock	    => clock_sig,
		dataa	    => dataa_sig,
		datab	    => datab_sig,
		result	 => result_sig
	);
	-- Çarpıcı
	mul1_inst : mul1 PORT MAP (
		aclr	    => aclr_sig,
		clk_en	 => clk_en_sig,
		clock	    => clock_sig,
		dataa	    => dataa_sig,
		datab	    => datab_sig,
		result	 => result_sig
	);
	-- Bölücü
	div1_inst : div1 PORT MAP (
		aclr	    => aclr_sig,
		clk_en	 => clk_en_sig,
		clock	    => clock_sig,
		dataa	    => dataa_sig,
		datab	    => datab_sig,
		result	 => result_sig
	);
	-- Exp function
	exp1_inst : exp1 PORT MAP (
		aclr	    => aclr_sig,
		clk_en	 => clk_en_sig,
		clock	    => clock_sig,
		data	    => data_sig,
		result	 => result_sig
	);
begin
