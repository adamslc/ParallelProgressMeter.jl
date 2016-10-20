# ParallelProgressMeter

Implements a version of [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl) that works for loops using the `@parallel` macro. To use it, replace `@parallel` with `@parallelprogress`.

This was partially modeled after [PmapProgressMeter.jl](https://github.com/slundberg/PmapProgressMeter.jl).
