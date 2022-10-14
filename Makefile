all:
	g++ ast-no-penalty.cc -o ast-no-penalty -mavx2
	g++ ast-penalty.cc -o ast-penalty -mavx2
run:
	@echo "Call sde64 -ast -- ast-no-penalty"
	~/sde/sde64 -ast -- ast-no-penalty
	@echo "avx-sse transition result:"
	cat sde-avx-sse-transition-out.txt
	mv sde-avx-sse-transition-out.txt sde-avx-sse-transition-out-no_penalty.txt
	@echo ""
	@echo "Call sde64 -ast -- ast-penalty"
	~/sde/sde64 -ast -debugtrace -- ast-penalty
	@echo "avx-sse transition result:"
	cat sde-avx-sse-transition-out.txt

clean:
	- rm sde* pin-tool-log.txt  ast-penalty ast-no-penalty

