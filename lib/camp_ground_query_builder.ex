defmodule CampGroundQueryBuilder do
  def for_ranges(query \\ %CampGroundQuery{}, start_date: start_date, end_date: end_date)  do
    start_dates_for_range(start_date: start_date, end_date: end_date)
    |> Enum.map(&(%{query | arrival_date: &1}))
    # split the date range into weeks and then make a different query for each
    # week
  end

  def start_dates_for_range(start_date: start_date, end_date: end_date) do
    date_offsets(start_date: start_date, end_date: end_date)
    |> Enum.map(&(Timex.shift(start_date, days: &1)))
  end

  def date_offsets(start_date: start_date, end_date: end_date) do
    Range.new(0, round(Timex.diff(end_date, start_date, :weeks) / 2))
    |> Enum.map(&(&1 * 14))
  end

  def for_number_of_sites(query) do
  end
end
