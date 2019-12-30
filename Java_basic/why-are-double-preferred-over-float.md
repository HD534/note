##Why are double preferred over float?

https://stackoverflow.com/questions/22818382/why-are-double-preferred-over-float

In my opinion the answers so far don't really get the right point across, so here's my crack at it.

The short answer is C++ developers use doubles over floats:

To avoid premature optimization when they don't understand the performance trade-offs well ("they have higher precision, why not?" Is the thought process)
Habit
Culture
To match library function signatures
To match simple-to-write floating point literals (you can write 0.0 instead of 0.0f)
It's true double may be as fast as a float for a single computation because most FPUs have a wider internal representation than either the 32-bit float or 64-bit double represent.

However that's only a small piece of the picture. Now-days operational optimizations don't mean anything if you're bottle necked on cache/memory bandwidth.

Here is why some developers seeking to optimize their code should look into using 32-bit floats over 64-bit doubles:

They fit in half the memory. Which is like having all your caches be twice as large. (big win!!!)
If you really care about performance you'll use SSE instructions. SSE instructions that operate on floating point values have different instructions for 32-bit and 64-bit floating point representations. The 32-bit versions can fit 4 values in the 128-bit register operands, but the 64-bit versions can only fit 2 values. In this scenario you can likely double your FLOPS by using floats over double because each instruction operates on twice as much data.
In general, there is a real lack of knowledge of how floating point numbers really work in the majority of developers I've encountered. So I'm not really surprised most developers blindly use double.