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
    IO.puts(Floki.text(page))
    Floki.find(page, ".status a")
    |> Enum.map(&availability_from_link(&1))
  end

  def availability_from_link(html) do
    [detail_url] = Floki.attribute(html, "a", "href")
    %CampSite{detail_url: detail_url}
  end
end
