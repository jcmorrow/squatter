defmodule Squatter do
  def main(_args) do
    HTTPotion.start

    # Lower Pines = 70928
    # North Pines = 70927
    # Upper Pines = 70925
    query = %CampGroundQuery{arrival_date: Timex.today, park_id: 70925 }
    output_availabilities(query)
  end

  def output_availabilities(query) do
    queries = CampGroundQueryBuilder.for_ranges(
      query,
      start_date: Timex.today,
      end_date: Timex.shift(Timex.today, weeks: 6),
      start_site: 1,
      end_site: 73,
    )

    availabilities = availabilities(queries)
    IO.puts("#{length(availabilities)} available campsites found. Listing weekend sites:")
    IO.puts(links_to_weekend_availabilities(availabilities))
  end

  def availabilities(queries) do
    Enum.flat_map(queries, &(availability_from_query(&1)))
  end

  def availability_from_query(query) do
    query
    |> CampGroundQuery.url_encoded
    |> CampPage.available_sites
  end

  def links_to_weekend_availabilities(availabilities) do
    availabilities
    |> Enum.filter(&(Timex.format!(&1.date, "%A", :strftime) == "Saturday"))
    |> Enum.map(&(CampPage.base_url <> &1.detail_url))
    |> Enum.join("\n")
  end
end
