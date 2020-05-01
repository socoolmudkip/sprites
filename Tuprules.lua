
tup.include("util/strict.lua")
tup.include("util/lua-ext.lua")
tup.include("util/tup-ext.lua")

function pad(w, h, input, output)
    return rep{
        "convert {input} -background transparent -gravity center -extent {w}x{h} {output}",
        input = input,
        output = output,
        w = w,
        h = h
    }
end

local DEFAULT_OPTIPNG = getconfig("DEFAULT_OPTIPNG")
local DEFAULT_ADVPNG = getconfig("DEFAULT_ADVPNG")

function compresspng(opts)
    local cmds = {}
    local output = opts.output or "%o"
    local optipng = DEFAULT_OPTIPNG
    if opts.config then
        optipng = getconfig(opts.config .. "_OPTIPNG") or optipng;
    end
    local advpng = DEFAULT_ADVPNG
    if opts.config then
        advpng = getconfig(opts.config .. "_ADVPNG") or advpng;
    end
    if optipng then
        cmds += rep{"optipng -q {opts} {output}", opts=optipng, output=output}
    end
    if advpng then
        cmds += rep{"advpng -q {opts} {output}", opts=advpng, output=output}
    end
    return cmds
end
