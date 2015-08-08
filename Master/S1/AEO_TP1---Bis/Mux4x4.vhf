--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 12.4
--  \   \         Application : sch2hdl
--  /   /         Filename : Mux4x4.vhf
-- /___/   /\     Timestamp : 09/26/2014 13:44:52
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl /home/m1/carette/Documents/TP1/Mux4x4.vhf -w /home/m1/carette/Documents/TP1/Mux4x4.sch
--Design Name: Mux4x4
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL M4_1E_HXILINX_Mux4x4 -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity M4_1E_HXILINX_Mux4x4 is
  
port(
    O   : out std_logic;

    D0  : in std_logic;
    D1  : in std_logic;
    D2  : in std_logic;
    D3  : in std_logic;
    E   : in std_logic;
    S0  : in std_logic;
    S1  : in std_logic
  );
end M4_1E_HXILINX_Mux4x4;

architecture M4_1E_HXILINX_Mux4x4_V of M4_1E_HXILINX_Mux4x4 is
begin
  process (D0, D1, D2, D3, E, S0, S1)
  variable sel : std_logic_vector(1 downto 0);
  begin
    sel := S1&S0;
    if( E = '0') then
    O <= '0';
    else
      case sel is
      when "00" => O <= D0;
      when "01" => O <= D1;
      when "10" => O <= D2;
      when "11" => O <= D3;
      when others => NULL;
      end case;
    end if;
    end process; 
end M4_1E_HXILINX_Mux4x4_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Mux4x4 is
   port ( I0 : in    std_logic_vector (3 downto 0); 
          l1 : in    std_logic_vector (3 downto 0); 
          l2 : in    std_logic_vector (3 downto 0); 
          l3 : in    std_logic_vector (3 downto 0); 
          S  : in    std_logic_vector (1 downto 0); 
          O  : out   std_logic_vector (3 downto 0));
end Mux4x4;

architecture BEHAVIORAL of Mux4x4 is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal XLXN_52 : std_logic;
   component M4_1E_HXILINX_Mux4x4
      port ( D0 : in    std_logic; 
             D1 : in    std_logic; 
             D2 : in    std_logic; 
             D3 : in    std_logic; 
             E  : in    std_logic; 
             S0 : in    std_logic; 
             S1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_2 : label is "XLXI_2_10";
   attribute HU_SET of XLXI_3 : label is "XLXI_3_11";
   attribute HU_SET of XLXI_4 : label is "XLXI_4_12";
   attribute HU_SET of XLXI_5 : label is "XLXI_5_13";
begin
   XLXI_2 : M4_1E_HXILINX_Mux4x4
      port map (D0=>I0(2),
                D1=>l1(2),
                D2=>l2(2),
                D3=>l3(2),
                E=>XLXN_52,
                S0=>S(0),
                S1=>S(1),
                O=>O(2));
   
   XLXI_3 : M4_1E_HXILINX_Mux4x4
      port map (D0=>I0(1),
                D1=>l1(1),
                D2=>l2(1),
                D3=>l3(1),
                E=>XLXN_52,
                S0=>S(0),
                S1=>S(1),
                O=>O(1));
   
   XLXI_4 : M4_1E_HXILINX_Mux4x4
      port map (D0=>I0(0),
                D1=>l1(0),
                D2=>l2(0),
                D3=>l3(0),
                E=>XLXN_52,
                S0=>S(0),
                S1=>S(1),
                O=>O(0));
   
   XLXI_5 : M4_1E_HXILINX_Mux4x4
      port map (D0=>I0(3),
                D1=>l1(3),
                D2=>l2(3),
                D3=>l3(3),
                E=>XLXN_52,
                S0=>S(0),
                S1=>S(1),
                O=>O(3));
   
   XLXI_6 : VCC
      port map (P=>XLXN_52);
   
end BEHAVIORAL;


