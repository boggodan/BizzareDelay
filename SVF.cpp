#include "math.h"

class StateVariableFilter
{
public:
	StateVariableFilter()
	{

	//	cutoff = 0.0f;
		f = 0;
		q = 0;
		low=high=band=notch= 0;
		scale = 0;

	}
	~StateVariableFilter()
	{
	}

	void SetCutoff(float cutoff)
	{
		f = 2 * sin(3.14 * (cutoff / 6.0f));
	}
	void SetResonance(float res)
	{
		//q = sqrtf(1.0f - atanf(sqrtf(res*100)) * 2.0f/3.14);
		q = 1 - res;
		scale = sqrtf(q);
		//q = 1 - res;
		//scale = q;
	}

	float Process(float input)
	{

		low = low + f * band + 1.0E-25;
		high = scale * input - low - q * band + 1.0E-25;
		band = f * high + band + 1.0E-25;
		notch = high + low + 1.0E-25;

		return low;
	}

private:

	float cutoff;
	float f;
	float q;
	float low,high,band,notch;
	float scale;



};