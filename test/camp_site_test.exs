defmodule CampSiteTest do
  use ExUnit.Case
  doctest CampSite

  test "initializing a site with data" do
    camp_site = %CampSite{site_number: 100, availabilities: []}

    assert(camp_site.availabilities == [])
    assert(camp_site.detail_url == nil)
    assert(camp_site.site_number == 100)
  end
end
