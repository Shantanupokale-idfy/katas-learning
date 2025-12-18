defmodule ElixirKatas.Katas.DynamicCompiler do
  @moduledoc """
  Compiles user code into ephemeral modules for isolation.
  """

  def compile(user_id, kata_name, source_code) do
    # 1. Generate unique module name
    # e.g. ElixirKatas.UserID.KataName
    module_name = Module.concat(["ElixirKatas", "User#{user_id}", Macro.camelize(kata_name)])
    
    # 2. Rewrite the source code to use this module name
    # This is a bit simplistic (regex replace), but works for PoC if we stick to conventions.
    # Assuming code starts with "defmodule ElixirKatasWeb.Kata..."
    
    # We need to find the original module name in the string and replace it.
    # Or strict convention: User provides body, we wrap it?
    # For now, let's try replacing the module definition line.
    
    new_source = 
      Regex.replace(
        ~r/defmodule\s+([a-zA-Z0-9._]+)\s+do/, 
        source_code, 
        "defmodule #{module_name} do", 
        global: false
      )

    # 3. Compile
    try do
      # Purge old version if exists to avoid "redefining module" warnings/errors in long run
      :code.purge(module_name)
      :code.delete(module_name)
      
      [{module, _bytecode}] = Code.compile_string(new_source)
      {:ok, module}
    rescue
      e -> {:error, e}
    catch
      k, e -> {:error, {k, e}}
    end
  end
end
