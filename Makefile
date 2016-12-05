
M_VIVADO := vivado -mode batch -source

ADI_IPS := axi_clkgen axi_hdmi_tx axi_spdif_tx

.PHONY: all $(ADI_IPS) clean

all: $(ADI_IPS)
	make -C oh/src/parallella/fpga/parallella_base all
#	make -C oh/src/parallella/fpga/headless all
	# remove old elink simulation for now $(M_VIVADO) elinkdv.tcl
	$(M_VIVADO) 7020_hdmi.tcl
	cd 7020_hdmi ; rm -f bit2bin.bin elink2_top_wrapper.bit.bin ; bootgen -image bit2bin.bif -split bin ; cd ..
	$(M_VIVADO) 7010_hdmi.tcl
	cd 7010_hdmi ; rm -f bit2bin.bin elink2_top_wrapper.bit.bin ; bootgen -image bit2bin.bif -split bin ; cd ..

$(ADI_IPS):
	make -C AdiHDLLib/library/$@

clean:
	make -C AdiHDLLib clean
	make -C oh/src/parallella/fpga/ clean
