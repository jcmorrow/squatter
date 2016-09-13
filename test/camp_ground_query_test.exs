defmodule CampGroundQueryTest do
  use ExUnit.Case
  doctest CampGroundQuery

  test "url_encoded" do
    query = %CampGroundQuery{
      park_id: 10,
      start_id: 25,
      arrival_date: Timex.parse!("09/10/2016", "%m/%d/%Y", :strftime)
    }

    assert(CampGroundQuery.url_encoded(query) == "camping/r/campsiteCalendar.do?page=calendar&search=site&contractCode=NRSO&parkId=10&calarvdate=09/10/2016&startIdx=25")
  end
end
