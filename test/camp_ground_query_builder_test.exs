defmodule CampGroundQueryBuilderTest do
  use ExUnit.Case
  doctest CampGroundQueryBuilder

  test "date_offsets for a range returns a list of integers" do
    date_offsets = CampGroundQueryBuilder.date_offsets(
      start_date: Timex.parse!("09/10/2016", "%m/%d/%Y", :strftime),
      end_date: Timex.parse!("09/24/2016", "%m/%d/%Y", :strftime),
    )

    assert(date_offsets == [0, 14])
  end

  test "start_dates_for_range" do
    start_dates_for_range = CampGroundQueryBuilder.start_dates_for_range(
      start_date: Timex.parse!("09/10/2016", "%m/%d/%Y", :strftime),
      end_date: Timex.parse!("09/24/2016", "%m/%d/%Y", :strftime),
    )

    assert(start_dates_for_range == [
      Timex.parse!("09/10/2016", "%m/%d/%Y", :strftime),
      Timex.parse!("09/24/2016", "%m/%d/%Y", :strftime),
    ])
  end

  test "for_ranges returns a set of queries for date and site ranges" do
    query = %CampGroundQuery{park_id: 12345}
    queries = CampGroundQueryBuilder.for_ranges(
      query,
      start_date: Timex.parse!("09/10/2016", "%m/%d/%Y", :strftime),
      end_date: Timex.parse!("09/24/2016", "%m/%d/%Y", :strftime),
    )

    assert(hd(queries).park_id == 12345)
    assert(length(queries) == 2)
  end
end
