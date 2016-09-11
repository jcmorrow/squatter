defmodule Squatter do
  def camps(query) do
    query
    |> CampGroundQuery.url_encoded
    |> CampPage.available_sites
  end
end

HTTPotion.start

queries = [
  %CampGroundQuery{
    camp_ground_slug: "Lower_Pines",
    arrival_date: Timex.today,
  },
  %CampGroundQuery{
    camp_ground_slug: "Lower_Pines",
    arrival_date: Timex.today,
    start_id: 25,
  },
  %CampGroundQuery{
    camp_ground_slug: "Lower_Pines",
    arrival_date: Timex.today,
    start_id: 50,
  },
]

queries
|> Enum.map(&(Squatter.camps(&1)))
|> IO.puts
