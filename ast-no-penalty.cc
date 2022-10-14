#include <cstring>
#include <iostream>

/**
 * AVX-SSE switch penalty happens when the CPU has to
 * save the 'dirty' up-part YMM register content.
 */

int main(int argc, char*argv[]){
	const int buf[8] = {-1, -1, -1, -1, -1, -1, -1, -1};
	bool avx512 = false;

	if (argc == 2 && !::strcmp(argv[1], "avx512"))
		avx512 = true;

	asm("vzeroupper");
	if (avx512) {
		std::cout << "AVX512-SSE Penalty" << std::endl;
		asm("vmovdqu8 %0, %%zmm0" : : "m"(buf));
		// Remove AVX-SSE transition penalty
		asm("vzeroupper");
		asm("movq  %rax, %xmm8");
	}else{
		std::cout << "AVX-SSE Penalty" << std::endl;
		asm("vmovdqu %0, %%ymm0" : : "m"(buf));
		// Remove AVX-SSE transition penalty
		asm("vzeroupper");
		asm("movq  %rax, %xmm8");
	}

	// If there is some SSE code called following by this
	// instruction then it will cause a AVX-SSE-MIX penaly.
	asm("vzeroupper");

	return 0;
}

