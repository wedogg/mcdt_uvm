class chnl_sequencer extends uvm_sequencer #(chnl_sequence_item);
  `uvm_component_utils(chnl_sequencer)
  function new (string name = "chnl_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass