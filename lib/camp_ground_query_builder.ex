defmodule CampGroundQueryBuilder do
  def for_ranges(query, start_date: start_date, end_date: end_date, start_site: start_site, end_site: end_site) do
    query
    |> for_date_ranges(start_date: start_date, end_date: end_date)
    |> Enum.flat_map(&(for_site_ranges(&1, start_site: start_site, end_site: end_site)))
  end

  def for_date_ranges(query, start_date: start_date, end_date: end_date) do
    start_dates_for_range(start_date: start_date, end_date: end_date)
    |> Enum.map(&(%{query | arrival_date: &1}))
  end

  def start_dates_for_range(start_date: start_date, end_date: end_date) do
    date_offsets(start_date: start_date, end_date: end_date)
    |> Enum.map(&(Timex.shift(start_date, days: &1)))
  end

  def date_offsets(start_date: start_date, end_date: end_date) do
    Range.new(0, round(Timex.diff(end_date, start_date, :days) / 14))
    |> Enum.map(&(&1 * 14))
  end

  def for_site_ranges(query, start_site: start_site, end_site: end_site) do
    site_offsets(end_site - start_site)
    |> Enum.map(&(%{query | start_id: &1}))
  end

  def site_offsets(number_of_sites) do
    offsets = Range.new(1, round(number_of_sites / 25))
    |> Enum.map(&(&1 * 25))
    [1 | offsets]
  end
end
