defmodule Delivery.PostalCode.DataParser do
    import Enum, only: [at: 2]

    @posta_codes "data/2016_Gaz_zcta_national.txt"


    def float(string) do
        String.trim(string)|> String.to_float
    end

    def parse_data do
        File.read!(@posta_codes)
        |> String.split("\n")
        |> tl()
        |> Enum.filter(fn(row) ->
             cls = String.split(row, "\t")
             at(cls, 0) != nil && at(cls,6) != nil
           end)
        |> Enum.map(fn(row) ->
             cls = String.split(row, "\t")
             [at(cls, 0), at(cls, 5), String.trim(at(cls, 6))]
           end)
        |> Enum.map(fn(row) ->
             {at(row, 0), {at(row, 1) |> float, at(row, 2) |> float }}
           end)
    end
end
