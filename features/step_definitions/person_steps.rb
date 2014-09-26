Given(/^an API path to the PersonsController$/) do
  @people_path = people_path
end

Given(/^a set of attributes for a person$/) do
  @person_params = FactoryGirl.attributes_for(:person)
end

When(/^I create a new person$/) do
  post @people_path, { person: @person_params}
end

Then(/^I get a successful response$/) do
  expect(last_response.status).to eq 200
end

Then(/^I receive back the information for the person$/) do
  @data = JSON.parse(last_response.body)
  expect(@data.keys).to match_array %w[id family_name given_name email phone]
end

Then(/^the attributes match$/) do
  step("family name matches")
  step("given name matches")
  step("email matches")
  step("phone matches")
end

Then(/^family name matches$/) do
  expect(@data['family_name']).to eq @person_params[:family_name]
end

Then(/^given name matches$/) do
  expect(@data['given_name']).to eq @person_params[:given_name]
end

Then(/^email matches$/) do
  expect(@data['email']).to eq @person_params[:email] 
end

Then(/^phone matches$/) do
  if @person_params.has_key? :phone
    expect(@data['phone']).to eq @person_params[:phone]     
  else
    true
  end
end


Given(/^(\d+) people with the family name of "(.*?)"$/) do |count, family_name|
  count.to_i.times { Person.create(FactoryGirl.attributes_for(:person, family_name: family_name)) }
end

Given(/^(\d+) people$/) do |count|
  count.to_i.times { Person.create(FactoryGirl.attributes_for(:person)) }  
end

When(/^I search for people with the family name "(.*?)"$/) do |family_name|
  get people_path(family_name: family_name)
end

Then(/^I receive (\d+) results$/) do |count|
  @data = JSON.parse(last_response.body)
  expect(@data.count).to eq count.to_i
end

Then(/^results have family name of "(.*?)"$/) do |family_name|
  expect(@data.all? {|x| x['family_name'] == family_name}).to eq true
end


