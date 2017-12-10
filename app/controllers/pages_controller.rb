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

  def sejarah
    
  end

  def visi
    
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
end
