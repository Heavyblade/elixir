defmodule Brakingwell do
    @g 9.81
    @t 1

    def dist(v, mu) do
        m_x_s = v * 1000 / 3600
        (m_x_s * m_x_s) / (2 * @g * mu) + m_x_s*@t
    end
    # suppose reaction time is 1
    def speed(d, mu) do
        :math.sqrt(d * (2 * @g * mu))
    end
end

IO.puts Brakingwell.dist(100, 0.7)

IO.puts Brakingwell.dist(100, 0.7) |> Brakingwell.speed(0.7)
