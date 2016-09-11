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
        %CampSite{
          detail_url: "/camping/Lower_Pines/r/campsiteDetails.do?siteId=203502&contractCode=NRSO&parkId=70928&offset=0&arvdate=9/14/2016&lengthOfStay=1",
          availabilities: [],
        },
        %CampSite{
          detail_url: "/camping/Lower_Pines/r/campsiteDetails.do?siteId=203502&contractCode=NRSO&parkId=70928&offset=0&arvdate=9/15/2016&lengthOfStay=1",
          availabilities: [],
        },
      ])
    end
  end
end
