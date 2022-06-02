`timescale 1ns/1ps
interface chnl_bfm(input clk, input rstn);
  import uvm_pkg::*;
  import chnl_pkg::*;
  `include "uvm_macros.svh"

  logic [31:0] ch_data;
  logic        ch_valid;
  logic        ch_ready;
  logic [ 5:0] ch_margin;
  
  clocking drv_ck @(posedge clk);
    default input #1ns output #1ns;
    output ch_data, ch_valid;
    input ch_ready, ch_margin;
  endclocking
  
  clocking mon_ck @(posedge clk);
    default input #1ns output #1ns;
    input ch_data, ch_valid, ch_ready, ch_margin;
  endclocking
endinterface