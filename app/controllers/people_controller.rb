class PeopleController < ApplicationController
  before_action :find_person, only: [:show, :edit, :update, :dest]

  def index
    family_name = params[:family_name]
    given_name  = params[:given_name]
    email       = params[:email]
    phone       = params[:phone]

    @people = []

    if family_name
      @people = Person.find_all_by_family_name(family_name)
    elsif given_name
      @people = Person.find_all_by_given_name(given_name)
    elsif email
      @people = Person.find_all_by_email(email)
    elsif phone
      @people = Person.find_all_by_phone(phone)
    end

    render json: @people.as_json
  end

  def show
    if @person
      render json: @person.as_json
    else
      render nothing: true, status: 404
    end
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      render json: @person.as_json
    else
      render json: {status: "400", message: "Unable to save person", errors: @person.errors }, status: 400
    end
  end

  private
  def find_person
    @person = Person.find_by_id(params[:id]) if params[:id]
  end

  def person_params
    params.require(:person).permit(:family_name, :given_name, :email, :phone)
  end
end
