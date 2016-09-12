defmodule Squatter do
  def main(_args) do
    HTTPotion.start

    # Lower Pines = 70928
    # North Pines = 70927
    base_query = %CampGroundQuery{
      arrival_date: Timex.today,
      park_id: 70927,
    }

    queries = CampGroundQueryBuilder.for_ranges(
      base_query,
      start_date: Timex.today,
      end_date: Timex.shift(Timex.today, weeks: 6),
    )

    availabilities = availabilities(queries)

    IO.puts("#{length(availabilities)} available campsites found. Listing weekend sites:")

    availabilities
    |> Enum.filter(&(Timex.format!(&1.date, "%A", :strftime) == "Saturday"))
    |> Enum.map(&("http://recreation.gov" <> &1.detail_url))
    |> Enum.join("\n")
    |> IO.puts
  end

  def availabilities(queries) do
    Enum.flat_map(queries, &(availability_from_query(&1)))
  end

  def availability_from_query(query) do
    query
    |> CampGroundQuery.url_encoded
    |> CampPage.available_sites
  end
end
