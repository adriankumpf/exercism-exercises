defmodule Markdown do
  @doc """
  Parses a given string with Markdown syntax and returns the associated HTML for that string.

  ## Examples

  iex> Markdown.parse("This is a paragraph")
  "<p>This is a paragraph</p>"

  iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
  "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> process_tags
    |> patch_lists
  end

  defp process("#" <> _ = line), do: line |> parse_header
  defp process("* " <> line), do: "<li>#{line}</li>"
  defp process(line), do: "<p>#{line}</p>"

  defp parse_header(str, lvl \\ 0)
  defp parse_header("#" <> tail, lvl), do: parse_header(tail, lvl + 1)
  defp parse_header(" " <> line, lvl), do: "<h#{lvl}>#{line}</h#{lvl}>"

  defp process_tags(str) do
    str
    |> String.replace( ~r/__([^_]+)__/, "<strong>\\1</strong>")
    |> String.replace( ~r/_([^_]+)_/, "<em>\\1</em>")
  end

  defp patch_lists(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end

end
