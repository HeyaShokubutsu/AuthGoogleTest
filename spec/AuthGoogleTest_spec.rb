require 'spec_helper'

RSpec.describe "Google Authorisation Page", type: :feature do

  scenario "Language changed to English" do

    visit "https://accounts.google.com/signin/v2/identifier"
    find( id: "lang-chooser" ).click                                 # open language selector
    find( "div" ){ |el| el[ "data-value" ] == "en" }.click           # choose English
    expect( page ).to have_content( "Use your Google Account" )
  end

  scenario "Proceeded to create new account" do

    visit "https://accounts.google.com/signin/v2/identifier"
    find( "div" ){ |el| el[ "jscontroller" ] == "iSvg6e" }.click     # open "create account" selector
    find( "div" ){ |el| el[ "jsname" ] == "RZzeR" }.click            # choose "Create for myself"
    expect( page ).to have_selector( "input", :id => "firstName" )
  end

  scenario "Account restore failed due to incorrect data" do

    visit "https://accounts.google.com/signin/v2/identifier"

    find( "button" ){ |el| el[ "jsname" ] == "Cuz2Ue" }.click        # click "Forgot email"
    find_field( name: "identifier" ).set( "some_unreadable_stuff" )  # add fake data
    find( id: "queryPhoneNext" ).click                               # proceed

    find_field( name: "firstName" ).set( "John" )                    # add fake data
    find_field( name: "lastName" ).set( "Doe" )                      #
    find( id: "collectNameNext" ).click                              # proceed

    expect( page ).to have_selector( "div", :class => "LXRPh" )      # check if red warning icon appeared
  end
end
