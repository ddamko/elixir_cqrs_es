defmodule DoSomething do
  def pass_me(args) do

    IO.write args[:hostname]

  end
end