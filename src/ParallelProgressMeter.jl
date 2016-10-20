module ParallelProgressMeter

using ProgressMeter

export @parallelprogress

globalProgressMeters = Dict()
globalProgressValues = Dict()
globalPrintLock      = Dict()

"""
    @parallelprogress p for i = 1:50
        # parallel computation goes here
    end

displays progress in parallel `for` loop using the `Progress` object `p`.
"""
macro parallelprogress(args...)
    if length(args) < 1
        throw(ArgumentError("@parallelprogress requires at least one argument."))
    end

    progressargs = args[1:end-1]
    loop = args[end]
    metersym = gensym("meter")

    if !(isa(loop, Expr) && loop.head === :for)
        throw(ArgumentError("Final argument to @parallelprogress must be a for loop."))
    end

    id = randstring(20)
    
    setup = quote
        iterable = $(esc(loop.args[1].args[2]))
        $(esc(metersym)) = Progress(length(iterable), $([esc(arg) for arg in progressargs]...))

        ParallelProgressMeter.globalProgressMeters[$(esc(id))] = $(esc(metersym))
        ParallelProgressMeter.globalProgressValues[$(esc(id))] = 0
        ParallelProgressMeter.globalPrintLock[$(esc(id))]      = ReentrantLock()
    end

    loop.args[2] = ProgressMeter.showprogress_process_expr(loop.args[2], metersym)
    push!(loop.args[2].args, :(remotecall(ParallelProgressMeter.updateProgressMeter, 1, $(esc(id)), 1)))

    return quote
        $setup
        @sync @parallel $loop
    end
end

function updateProgressMeter(id, n)
    global globalProgressMeters
    global globalProgressValues
    global globalPrintLock

    lock(globalPrintLock[id])
    globalProgressValues[id] += n
    update!(globalProgressMeters[id], globalProgressValues[id])
    unlock(globalPrintLock[id])
end

end # module
