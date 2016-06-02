require 'rails_helper'

RSpec.describe "hotels/edit", type: :view do
  before(:each) do
    @hotel = assign(:hotel, Hotel.create!(
      :name => "MyString",
      :address => "MyString",
      :star_rating => 1,
      :accomodation_type => "MyString"
    ))
  end

  it "renders the edit hotel form" do
    render

    assert_select "form[action=?][method=?]", hotel_path(@hotel), "post" do

      assert_select "input#hotel_name[name=?]", "hotel[name]"

      assert_select "input#hotel_address[name=?]", "hotel[address]"

      assert_select "input#hotel_star_rating[name=?]", "hotel[star_rating]"

      assert_select "input#hotel_accomodation_type[name=?]", "hotel[accomodation_type]"
    end
  end
end
