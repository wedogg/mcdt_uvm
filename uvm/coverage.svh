
`uvm_analysis_imp_decl(_chnl_0)
`uvm_analysis_imp_decl(_chnl_1)
`uvm_analysis_imp_decl(_chnl_2)

class my_coverage extends uvm_component;
  `uvm_component_utils(my_coverage)
  bit [31:0] chnl_data[3];

  uvm_analysis_imp_chnl_0 #(mon_data_t, my_coverage) chnl_0_cov_imp;
  uvm_analysis_imp_chnl_1 #(mon_data_t, my_coverage) chnl_1_cov_imp;
  uvm_analysis_imp_chnl_2 #(mon_data_t, my_coverage) chnl_2_cov_imp;

  covergroup data_cov;

    coverpoint chnl_data[0] {
      bins range = {['hc000_0000:'hc0000_0fff]};
    }
    coverpoint chnl_data[1] {
      bins range = {['hc100_0000:'hc1000_0fff]};
    }
    coverpoint chnl_data[2] {
      bins range = {['hc200_0000:'hc2000_0fff]};
    }
  endgroup

  function new (string name = "my_coverage", uvm_component parent);
    super.new(name, parent);
    data_cov = new();
    chnl_0_cov_imp = new("chnl_0_cov_imp", this);
    chnl_1_cov_imp = new("chnl_1_cov_imp", this);
    chnl_2_cov_imp = new("chnl_2_cov_imp", this);
  endfunction

  function void write_chnl_0(mon_data_t t);
    chnl_data[0] = t.data;
    data_cov.sample();
  endfunction
  function void write_chnl_1(mon_data_t t);
    chnl_data[1] = t.data;
    data_cov.sample();
  endfunction
  function void write_chnl_2(mon_data_t t);
    chnl_data[2] = t.data;
    data_cov.sample();
  endfunction
endclass