`timescale 1ns/1ps
interface mcdt_bfm(input clk, input rstn);
  import uvm_pkg::*;
  import chnl_pkg::*;
  `include "uvm_macros.svh"
  logic [31:0]  mcdt_data;
  logic         mcdt_val;
  logic [ 1:0]  mcdt_id;
  
  clocking mon_ck @(posedge clk);
    default input #1ns output #1ns;
    input mcdt_data, mcdt_val, mcdt_id;
  endclocking
endinterface