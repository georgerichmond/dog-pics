class DogsController < ApplicationController
  require 'net/http'

  def fetch_dog_image
    breed = params[:breed].strip.downcase

    if breed.blank?
      @breed = params[:breed]
      @image_url = nil
      @message = "Breed name cannot be empty. Please enter a valid breed."
    else
      breed_parts = breed.split
      if breed_parts.size > 1
        parent_breed = URI.encode_www_form_component(breed_parts[1])
        sub_breed = URI.encode_www_form_component(breed_parts[0])
        url = URI("https://dog.ceo/api/breed/#{parent_breed}/#{sub_breed}/images/random")
      else
        encoded_breed = URI.encode_www_form_component(breed)
        url = URI("https://dog.ceo/api/breed/#{encoded_breed}/images/random")
      end

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

  def breeds
    @breeds = Rails.cache.fetch("breeds", expires_in: 12.hours) do
      url = URI("https://dog.ceo/api/breeds/list/all")
      response = Net::HTTP.get(url)
      data = JSON.parse(response)

      data["status"] == "success" ? data["message"] : {}
    end

    query = params[:query].strip.downcase

    @suggestions = []
    @breeds.each do |parent, sub_breeds|
      if parent.start_with?(query)
        @suggestions << parent
      end

      sub_breeds.each do |sub_breed|
        combined_breed = "#{sub_breed} #{parent}"
        if combined_breed.include?(query)
          @suggestions << combined_breed
        end
      end
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
