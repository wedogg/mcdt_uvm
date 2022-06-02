`timescale 1ns/1ps

module top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import chnl_pkg::*;
  
  chnl_bfm chnl0_if(.*);
  chnl_bfm chnl1_if(.*);
  chnl_bfm chnl2_if(.*);
  mcdt_bfm mcdt_if(.*);

  logic clk;
  logic rstn;

  mcdt dut(
     .clk_i       (clk                )
    ,.rstn_i      (rstn               )
    ,.ch0_data_i  (chnl0_if.ch_data   )
    ,.ch0_valid_i (chnl0_if.ch_valid  )
    ,.ch0_ready_o (chnl0_if.ch_ready  )
    ,.ch0_margin_o(chnl0_if.ch_margin )
    ,.ch1_data_i  (chnl1_if.ch_data   )
    ,.ch1_valid_i (chnl1_if.ch_valid  )
    ,.ch1_ready_o (chnl1_if.ch_ready  )
    ,.ch1_margin_o(chnl1_if.ch_margin )
    ,.ch2_data_i  (chnl2_if.ch_data   )
    ,.ch2_valid_i (chnl2_if.ch_valid  )
    ,.ch2_ready_o (chnl2_if.ch_ready  )
    ,.ch2_margin_o(chnl2_if.ch_margin )
    ,.mcdt_data_o (mcdt_if.mcdt_data  )
    ,.mcdt_val_o  (mcdt_if.mcdt_val   )
    ,.mcdt_id_o   (mcdt_if.mcdt_id    )
  );

  initial begin 
    clk <= 0;
    forever begin
      #5 clk <= !clk;
    end
  end
  
  // reset trigger
  initial begin 
    #10 rstn <= 0;
    repeat(10) @(posedge clk);
    rstn <= 1;
  end
  
  initial begin
  
  uvm_config_db #(virtual chnl_bfm)::set(null, "*", "chnl0_bfm", chnl0_if);
  uvm_config_db #(virtual chnl_bfm)::set(null, "*", "chnl1_bfm", chnl1_if);
  uvm_config_db #(virtual chnl_bfm)::set(null, "*", "chnl2_bfm", chnl2_if);
  uvm_config_db #(virtual mcdt_bfm)::set(null, "*", "mcdt_bfm", mcdt_if);
  run_test("my_test");
  end


endmodule:top