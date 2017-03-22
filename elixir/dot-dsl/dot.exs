defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do
  defmacro graph(ast) do

    find_elements = fn(arg, {nodes, edges, attrs}) ->
      new_nodes = case arg do
        nil -> []
        {:graph, _, _} -> []
        {:--, _, _} -> []
        {_, _, [[_, x]]} when is_tuple(x) -> raise ArgumentError
        {key, _, nil} when is_atom(key) -> [{key, []}]
        {key, _, [args]} when is_atom(key) and is_list(args) -> [{key, args}]
        _  -> raise ArgumentError
      end

      new_edges = case arg do
        {:--, _, [{edge1, _, _}, {edge2, _, [args]}]} when is_atom(edge1) and is_atom(edge2) -> [{:{}, [], [edge1, edge2, args]}]
        {:--, _, [{edge1, _, _}, {edge2, _, _}]} when is_atom(edge1) and is_atom(edge2) -> [{:{}, [], [edge1, edge2, []]}]
        {:--, _, _} -> raise ArgumentError
        _ -> []
      end

      new_attrs = case arg do
        {:graph, _, [args]} -> args
        _ -> []
      end

      {nodes ++ new_nodes, edges ++ new_edges, attrs ++ new_attrs}
    end

    {block_type, _, arg_list} = case ast[:do] do
      nil -> {nil, nil, nil}
      x when is_tuple(x) -> ast[:do]
      _  -> raise ArgumentError
    end
    {nodes, edges, attrs} = case block_type do
      :__block__ -> Enum.reduce(arg_list, {[], [], []}, find_elements)
      _ -> find_elements.(ast[:do], {[], [], []})
    end

    quote do
      %Graph{
        nodes: unquote(nodes |> Enum.sort),
        edges: unquote(edges |> Enum.sort),
        attrs: unquote(attrs |> Enum.sort)}
    end
  end
end
