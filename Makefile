all:
	g++ ast-no-penalty.cc -o ast-no-penalty
	g++ ast-penalty.cc -o ast-penalty
run:
	@echo "Run ast-penalty @avx2 on CPU 1, try to capture "ASSISTS.SSE_AVX_MIX" event"
	emon -t0 -C "ASSISTS.SSE_AVX_MIX"  /usr/bin/taskset -c 1 ./ast-penalty |grep 'ASSISTS.SSE_AVX_MIX'
	@echo ""
	@echo "Run ast-no-penalty @avx2 on CPU 1, try to capture "ASSISTS.SSE_AVX_MIX" event"
	emon -t0 -C "ASSISTS.SSE_AVX_MIX"  /usr/bin/taskset -c 1 ./ast-no-penalty |grep 'ASSISTS.SSE_AVX_MIX'
	echo ""
	@echo "Run ast-penalty @avx512 on CPU 1, try to capture "ASSISTS.SSE_AVX_MIX" event"
	emon -t0 -C "ASSISTS.SSE_AVX_MIX"  /usr/bin/taskset -c 1 ./ast-penalty avx512 |grep 'ASSISTS.SSE_AVX_MIX'
	@echo ""
	@echo "Run ast-no-penalty @avx512 on CPU 1, try to capture "ASSISTS.SSE_AVX_MIX" event"
	emon -t0 -C "ASSISTS.SSE_AVX_MIX"  /usr/bin/taskset -c 1 ./ast-no-penalty avx512 |grep 'ASSISTS.SSE_AVX_MIX'

sde:
	sde64 -ast -debugtrace -- ./ast-penalty

clean:
	- rm ast-penalty ast-no-penalty sde* pin*

