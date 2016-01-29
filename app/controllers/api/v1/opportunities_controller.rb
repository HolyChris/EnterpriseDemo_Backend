require 'digest/sha1'

class Api::V1::OpportunitiesController < Api::V1::BaseController

  skip_before_action :authenticate_user_from_token!
  before_action :authenticate_with_token!

  def create

    opportunity = params[:opportunity]
    state = State.find_by_name opportunity[:state]
    state = State.find_by_abbr opportunity[:state].upcase unless state

    begin
      ActiveRecord::Base.transaction do

        @customer = Customer.create! firstname: opportunity[:first_name], lastname: opportunity[:last_name],
                                     email: opportunity[:email],
                                     addresses_attributes: [
                                         {
                                             address1: opportunity[:address_1], city: opportunity[:city],
                                             state: state, country: Country.first,
                                             zipcode: opportunity[:zipcode], address2: opportunity[:address_2]
                                         }
                                     ],
                                     phone_numbers_attributes: [{number: opportunity[:primary_phone_number], num_type: 1, primary: true}]

        @site = Site.create! stage: 'lead', address: @customer.addresses[0], customer: @customer
        render json: {stat: 'ok' }, status: 200
      end
    rescue => e
      render json: {stat: 'fail', message: e.message}, status: 200
    end

  end

  private

  def authenticate_with_token!
    if params[:token] != calculate_token
      render json: {message: 'Not authorized to perform the operation'}, status: 404
    end
  end

  def calculate_token
    Digest::SHA1.hexdigest("/#{params[:opportunity].try(:[], :email)}/#{params[:opportunity].try(:[], :first_name)}")
  end
end
