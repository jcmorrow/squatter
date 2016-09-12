defmodule CampPage do
  @base_url "http://www.recreation.gov/camping/"

  def base_url do
    @base_url
  end

  def get_content(camp_ground_query_url) do
    HTTPotion.get(@base_url <> camp_ground_query_url).body
  end

  def available_sites(camp_ground_query_url) do
    page = get_content(camp_ground_query_url)
    page
    |> Floki.find("tbody")
    |> Floki.text
    |> IO.puts

    Floki.find(page, ".status a")
    |> Enum.map(&availability_from_link(&1))
  end

  def availability_from_link(html) do
    [detail_url] = Floki.attribute(html, "a", "href")
    [_match, date_string] = Regex.run(~r/arvdate=(.*)&/, detail_url)
    IO.puts(date_string)
    %CampSiteAvailability{
      detail_url: detail_url,
      date: Timex.parse!(pad_leading_zero(date_string), "%m/%e/%Y", :strftime),
    }
  end

  def pad_leading_zero(date_string) do
    if Regex.match?(~r{^[1-9]/}, date_string) do
      "0" <> date_string
    else
      date_string
    end
  end
end
