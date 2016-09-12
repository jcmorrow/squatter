defmodule CampGroundQuery do
  defstruct(
    arrival_date: Timex.now,
    park_id: nil,
    start_id: 1,
  )

  def url_encoded(query) do
    Enum.join(
      [
        "r/campsiteCalendar.do?page=calendar&search=site&contractCode=NRSO&",
        "parkId=#{query.park_id}&",
        "calarvdate=#{formatted_arrival_date(query.arrival_date)}&",
        "startIdx=#{query.start_id}",
      ]
    )
  end

  def formatted_arrival_date(date) do
    Timex.format!(date, "%m/%d/%Y", :strftime)
  end
end
