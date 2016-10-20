addprocs(4)

using ProgressMeter
using ParallelProgressMeter

@parallelprogress for i in 1:50
    sleep(0.1)
end

@parallelprogress 0.5 "Testing..." for i in 1:50
    sleep(0.1)
end
