defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true

  def saluda do
  end
end

defmodule Caller do
  def saludame do
    s1 = %Subscriber{name: "Cristian"}
    IO.puts s1.name
  end

  def pattern do
      s1 = %Subscriber{name: "Camilo"}
      %{name: name} = s1
      IO.puts name
  end
end

# Caller.saludame
# Caller.pattern

defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}) do
     attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Attendee{name:  name}) when name != "" do
    IO.puts "Very cheap badget for #{name}"
  end
  def print_vip_badge(%Attendee{}) do
    raise "missing name for badge"
  end
end

# attende = %Attendee{name: "Dave", over_18: true}

# IO.puts Attendee.may_attend_after_party(attende)
