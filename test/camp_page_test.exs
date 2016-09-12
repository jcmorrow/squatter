defmodule CampPageTest do
  use ExUnit.Case
  doctest CampPage
  import Mock

  test "get_content requests the URL" do
    with_mock HTTPotion, [get: fn(_url) -> %{body: "<html></html>"} end] do
      CampPage.get_content("lower-pines")

      assert called HTTPotion.get(CampPage.base_url <> "lower-pines")
    end
  end

  test "available_sites returns an empty list when there are no sites" do
    with_mock HTTPotion, [get: fn(_url) -> %{body: "<html></html>"} end] do
      assert(CampPage.available_sites("lonely-pines") == [])
    end
  end

  test "available_sites returns a list of CampSites" do
    {:ok, page_html} = File.read("test/fixtures/camp_page_with_sites.html")
    with_mock HTTPotion, [get: fn(_url) -> %{body: page_html} end] do
      assert(CampPage.available_sites("foo") == [
        %CampSiteAvailability{
          detail_url: "/camping/Lower_Pines/r/campsiteDetails.do?siteId=203502&contractCode=NRSO&parkId=70928&offset=0&arvdate=9/14/2016&lengthOfStay=1",
          date: Timex.parse!("09/14/2016", "%m/%d/%Y", :strftime),
        },
        %CampSiteAvailability{
          detail_url: "/camping/Lower_Pines/r/campsiteDetails.do?siteId=203502&contractCode=NRSO&parkId=70928&offset=0&arvdate=9/15/2016&lengthOfStay=1",
          date: Timex.parse!("09/15/2016", "%m/%d/%Y", :strftime),
        },
      ])
    end
  end

  test "pad_leading_zero when there is already a leading zero" do
    assert(CampPage.pad_leading_zero("01/01/2015") == "01/01/2015")
  end

  test "pad_leading_zero when there is not leading zero" do
    assert(CampPage.pad_leading_zero("1/01/2015") == "01/01/2015")
  end

  test "pad_leading_zero when the month is Oct, Nov, Dec" do
    assert(CampPage.pad_leading_zero("10/01/2015") == "10/01/2015")
    assert(CampPage.pad_leading_zero("11/01/2015") == "11/01/2015")
    assert(CampPage.pad_leading_zero("12/01/2015") == "12/01/2015")
  end
end
