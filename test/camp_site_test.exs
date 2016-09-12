defmodule CampSiteAvailabilityTest do
  use ExUnit.Case
  doctest CampSiteAvailability

  test "initializing a site with data" do
    camp_site = %CampSiteAvailability{site_number: 100, date: Timex.today}

    assert(camp_site.date == Timex.today)
    assert(camp_site.detail_url == nil)
    assert(camp_site.site_number == 100)
  end
end
