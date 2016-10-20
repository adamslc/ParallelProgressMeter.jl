# ParallelProgressMeter

This package implements a version of [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl) that works for loops using the `@parallel` macro.

It was partially modeled after [PmapProgressMeter.jl](https://github.com/slundberg/PmapProgressMeter.jl).

## Installation
    Pkg.clone("https://github.com/adamslc/ParallelProgressMeter.jl")
    
## Usage
    using ParallelProgressMeter
    
    @parallelprogress for i in 1:50
        sleep(0.2)
    end
    
## Bugs / Quirks / Todo list
 *  Currently, the package doesn't allow the use of a reduction operator. The main difficulty is differentiating
    between the arguments for the progress meter and the reduction opperator.
