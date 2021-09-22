defmodule Extractly.Xtra do
  alias Extractly.Messages, as: M

  @moduledoc """
  This wraps `Extractly's` API by putting all messages to be logged to the
  `Extractly.Messages` module.

  Its primarty use case is for `Mix.Tasks.Xtra` which will pass this module
  as a param into the `EEx` template.

  The general idea is

  ```elixir
  Extractly.Messages.start_agent
  process_input_template # which will collect messages by means of this module's API
  Extractly.Messages.get_all |> emit_messages(options)

  ```

  The wrapping works as follows

  ```elixir
    def some_function(some_params) do
      case Extractly.some_function(some_params) do
        {:ok, result} -> result
        {:error, message} -> add_message_to_messages_and_return_html_comment_describing_the_error()
      end
    end
  ```

  """

  @doc ~S"""
  Just a delegator to `Extractly.do_not_edit_warning`
  As there can be no error condition no wrapping is needed

    iex(1)> do_not_edit_warning()
    "<!--\nDO NOT EDIT THIS FILE\nIt has been generated from a template by Extractly (https://github.com/RobertDober/extractly.git)\nand any changes you make in this file will most likely be lost\n-->"
  """
  defdelegate do_not_edit_warning(opts \\ []), to: Extractly

  @doc false
  defdelegate version, to: Extractly

  @doc ~S"""
  Wraps call to `Extractly.functiondoc` as described above 

      iex(2)> functiondoc(["Support.Module2.function/0", "Support.Module1.hello/0"])
      "A function\nA nice one\n\nFunctiondoc of Module1.hello\n"
  """
  def functiondoc(name, opts \\ []) do
    M.add_debug("functiondoc called for #{name} #{inspect opts}")
    Extractly.functiondoc(name, opts)
    |> _split_outputs([])
  end

  @doc ~S"""
  Wraps call to `Extractly.moduledoc` as described above 

      iex(3)> moduledoc("Support.Module2")
      "<!-- module Support.Module2 does not have a moduledoc -->"
  """
  def moduledoc(name, opts \\ []) do
    M.add_debug("moduledoc called for #{name} #{inspect opts}")
    case Extractly.moduledoc(name, opts) do
      {:ok, result} -> result
      {:error, message} -> _add_error(message)
    end
  end

  defp _add_error(message) do
    M.add_error(message)
    "<!-- #{message} -->"
  end

  defp _split_outputs(fdoc_tuples, result)
  defp _split_outputs([], result), do: result |> Enum.reverse |> Enum.join("\n")
  defp _split_outputs([{:error, message}|rest], result) do
    _add_error(message)
    _split_outputs(rest, result)
  end
  defp _split_outputs([{:ok, doc}|rest], result) do
    _split_outputs(rest, [doc|result])
  end
end