require 'spec_helper'

describe "tuiles/index" do
  before(:each) do
    assign(:tuiles, [
      stub_model(Tuile,
        :lien => "Lien",
        :image => "Image",
        :titre => "Titre",
        :description => "MyText",
        :forme => "Forme"
      ),
      stub_model(Tuile,
        :lien => "Lien",
        :image => "Image",
        :titre => "Titre",
        :description => "MyText",
        :forme => "Forme"
      )
    ])
  end

  it "renders a list of tuiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lien".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Titre".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
