defmodule CampGroundQuery do
  defstruct(
    camp_ground_slug: "",
    arrival_date: Timex.now,
    start_id: 1,
    park_id: "7092",
  )

  def url_encoded(query) do
    Enum.join(
      [
        query.camp_ground_slug,
        "/r/campsiteCalendar.do?page=calendar&search=site&contractCode=NRSO&",
        "park_id=#{query.park_id}&",
        "arrival_date=#{formatted_arrival_date(query.arrival_date)}&",
        "start_id=#{query.start_id}",
      ]
    )
  end

  def formatted_arrival_date(date) do
    Timex.format!(date, "%m/%d/%Y", :strftime)
  end
end
