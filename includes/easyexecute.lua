local EasyExecute = {}
EasyExecute.execute = function(code, env, stripDebugSymbols)
    local executor = loadlib("Executor")
    local env = env or loadlib("EnvTable")
    local stripDebugSymbols = stripDebugSymbols or false
    local compiled, error = executor.compile(code, env, stripDebugSymbols)
    if compiled == 1 then
        print(error)
    else
        executor.run(compiled, env)()
    end
end
return EasyExecute
