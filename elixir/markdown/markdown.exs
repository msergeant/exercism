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
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join
    |> patch
  end

  defp process(t) do
    first_letter = t |> String.graphemes |> List.first

    case first_letter do
      "#" -> enclose_with_header_tag(parse_header_md_level(t))
      "*" -> parse_list_md_level(t)
      _ -> enclose_with_paragraph_tag(String.split(t))
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_tag(tag, content) do
    "<#{tag}>#{content}</#{tag}>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    enclose_with_tag("h" <> hl, htl)
  end

  defp enclose_with_paragraph_tag(t) do
    enclose_with_tag("p", join_words_with_tags(t))
  end

  defp join_words_with_tags(t) do
    t
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    w
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^__/ -> String.replace(w, ~r/^__/, "<strong>")
      w =~ ~r/^_/ -> String.replace(w, ~r/^_/, "<em>")
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/__$/ -> String.replace(w, ~r/__$/, "</strong>")
      w =~ ~r/_$/ -> String.replace(w, ~r/_$/, "</em>")
      true -> w
    end
  end

  defp patch(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
