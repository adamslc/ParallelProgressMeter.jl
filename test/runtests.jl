addprocs(4)

using ProgressMeter
using ParallelProgressMeter

@parallelprogress for i in 1:10
    sleep(0.1)
end
