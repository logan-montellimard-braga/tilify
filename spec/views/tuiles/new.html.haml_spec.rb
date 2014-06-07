require 'spec_helper'

describe "tuiles/new" do
  before(:each) do
    assign(:tuile, stub_model(Tuile,
      :lien => "MyString",
      :image => "MyString",
      :titre => "MyString",
      :description => "MyText",
      :forme => ""
    ).as_new_record)
  end

  it "renders new tuile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tuiles_path, "post" do
      assert_select "input#tuile_lien[name=?]", "tuile[lien]"
      assert_select "input#tuile_image[name=?]", "tuile[image]"
      assert_select "input#tuile_titre[name=?]", "tuile[titre]"
      assert_select "textarea#tuile_description[name=?]", "tuile[description]"
      assert_select "input#tuile_type[name=?]", "tuile[type]"
    end
  end
end
