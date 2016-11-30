defmodule Buycar do

  def nb_months(startPriceOld, startPriceNew, _savingperMonth, _percentLossByMonth) when startPriceOld >= startPriceNew do
      { 0, startPriceOld - startPriceNew }
  end

  def nb_months(startPriceOld, startPriceNew, savingperMonth, percentLossByMonth) do
      save(0, startPriceOld, startPriceNew, percentLossByMonth/100, savingperMonth)
  end

  def save(month, old_price, new_price, _perc_loss, saving) when (old_price + (month * saving) - new_price) >= 0 do
      { month, (old_price + (month*saving) - new_price) |> Float.round(0) }
  end

  def save(month, old_price, new_price, perc_loss, saving) do
      save(month+1, old_price * ( 1 - perc_loss), new_price * ( 1 - perc_loss), (if rem(month,2) == 0, do: perc_loss + 0.005, else: perc_loss ), saving)
  end

end

IO.puts Buycar.nb_months(2000, 8000, 1000, 1.5)
