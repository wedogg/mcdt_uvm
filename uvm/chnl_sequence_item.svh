class chnl_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(chnl_sequence_item)
    
  rand bit[31:0] data[];
  rand int ch_id;
  rand int pkt_id;
  rand int data_nidles;
  rand int pkt_nidles;
  bit rsp;
  local static int obj_id = 0;
  
  constraint chnl_item_constraint{
    soft data.size inside {[4:8]};
    foreach(data[i]) data[i] == 'hC000_0000 + (this.ch_id<<24) + (this.pkt_id<<8) + i;
    soft ch_id == 0;
    soft pkt_id == 0;
    soft data_nidles inside {[0:2]};
    soft pkt_nidles inside {[1:10]};
  };


  function new(input string name = "chnl_sequence_item");
    super.new(name);
  endfunction

  function string sprint();
    string s;
    s = {s, $sformatf("=======================================\n")};
    s = {s, $sformatf("chnl_sequence_item object content is as below: \n")};
    s = {s, $sformatf("obj_id = %0d: \n", this.obj_id)};
    foreach(data[i]) s = {s, $sformatf("data[%0d] = %8x \n", i, this.data[i])};
    s = {s, $sformatf("ch_id = %0d: \n", this.ch_id)};
    s = {s, $sformatf("pkt_id = %0d: \n", this.pkt_id)};
    s = {s, $sformatf("data_nidles = %0d: \n", this.data_nidles)};
    s = {s, $sformatf("pkt_nidles = %0d: \n", this.pkt_nidles)};
    s = {s, $sformatf("rsp = %0d: \n", this.rsp)};
    s = {s, $sformatf("=======================================\n")};
    return s;
    
  endfunction

endclass
