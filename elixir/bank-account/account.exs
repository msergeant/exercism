defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Task.start_link(fn -> loop(%{ balance: 0 }) end)

    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    send account, {:get_balance, self()}
    receive do
     {balance} -> balance
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    send account, {:update_balance, amount, self()}
    receive do
     {map} -> {:ok, map}
    end
  end

  defp loop(map) do
    receive do
      {:get_balance, caller} -> send( caller, {Map.fetch!(map, :balance)}); loop(map)
      {:update_balance, amount, caller} -> new_map = add_to_balance(map, amount); send( caller, {new_map}); loop(new_map)
    end
  end

  defp add_to_balance(map, amount) do
    old_balance = Map.fetch!(map, :balance)
    Map.merge(map, %{ balance: old_balance + amount })
  end
end
