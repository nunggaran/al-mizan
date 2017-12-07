class PagesController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  def index
    #response = HTTParty.post('https://indoexchanger.co.id/private/rest/indoExchanger/amountBitcoin')
    #puts response.body, response.code, response.message, response.headers.inspect
    # Rails.logger.info(amount_btc)
    # Price.create(amount_params)
    # Rails.logger.info("=== Data Saved === ")
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = "Thank u for cantacting us, We'll contact u back soon"
    end
  end

  def deposito_bitcoin
  	
  end

  def calculator_bitcoin
  	
  end

  def cara_registrasi_akun
  	
  end

  def about_us
    
  end

  def cara_mendapatkan_bitcoin
    
  end

  def contact_us
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = "Thank u for cantacting us, We'll contact u back soon"
    end
    
  end

  def rivan
    
  end
  
  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.permit(:first_name, :last_name, :email, :message)
    end
    # def amount_btc
    #   response = HTTParty.post('https://indoexchanger.co.id/private/rest/indoExchanger/amountBitcoin', format: :plain)
    #   parsing = JSON.parse response
    #   # Rails.logger.info("#{parsing} yeah.. 🎉")
    #   return parsing
    # end

    # def amount_params
    #   [
    #     {
    #       amount_idr: amount_btc["amountIDR"],
    #       amount_usd: amount_btc["amountUSD"],
    #       time:       amount_btc["time"]
    #     }
    #   ]
    # end
end
