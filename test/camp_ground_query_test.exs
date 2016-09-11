defmodule CampGroundQueryTest do
  use ExUnit.Case
  doctest CampGroundQuery

  test "url_encoded" do
    query = %CampGroundQuery{
      camp_ground_slug: "lower-pines",
      park_id: 10,
      start_id: 25,
      arrival_date: Timex.parse!("09/11/2016", "%m/%d/%Y", :strftime)
    }

    assert(CampGroundQuery.url_encoded(query) == "lower-pines/r/campsiteCalendar.do?page=calendar&search=site&contractCode=NRSO&park_id=10&arrival_date=09/11/2016&start_id=25")
  end
end
