using ProgressMeter
using ParallelProgressMeter

addprocs(4)
@parallelprogress for i in 1:10
    sleep(0.1)
end
