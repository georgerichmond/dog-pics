class DogsController < ApplicationController
  require 'net/http'

  def fetch_dog_image
    breed = params[:breed].strip.downcase

    if breed.blank?
      @breed = params[:breed]
      @image_url = nil
      @message = "Breed name cannot be empty. Please enter a valid breed."
    else
      url = URI("https://dog.ceo/api/breed/#{breed}/images/random")
      response = Net::HTTP.get(url)
      data = JSON.parse(response)

      Rails.logger.debug "API Response: #{data}"

      @breed = params[:breed]
      if data['status'] == 'success'
        @image_url = data['message']
        @message = "Here's your pic for #{@breed}"
      else
        @image_url = nil
        @message = "#{@breed} not found. Perhaps try a different breed, like 'Corgi'"
      end
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end
end
