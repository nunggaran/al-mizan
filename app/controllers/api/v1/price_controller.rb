module Api
	module V1
		class PriceController < ActionController::Base
			# protect_from_forgery prepend: true, with: :exception
			def create
				price = Price.new(amount_params)
				if price.save
					 puts render json: {status: 'SUCCESS', message:'Price Saved', data:price},status: :ok
        else
          puts render json: {status: 'ERROR', message:'Price not saved', data:price.errors},status: :unprocessable_entity
        end
			end

			def show
				price = Price.find_by_id(params[:id])
				# Rails.logger.info("==== Sukses article ======")
				puts price.time.to_s.split(" ").first
				render json: {status: 'hoho Sukses', message: 'Prie Loaded', data:price.present? ? price : 'Record not found'}, status: :ok
			end

			private
	    def amount_btc
	      response = HTTParty.post('https://indoexchanger.co.id/private/rest/indoExchanger/amountBitcoin', format: :plain)
	      parsing = JSON.parse response
	      # Rails.logger.info("#{parsing} yeah.. 🎉")
	      return parsing
	    end

	    def amount_params
        { amount_idr: amount_btc["amountIDRBuy"], amount_usd: amount_btc["amountUSD"], time:       amount_btc["time"] }
	    end
		end
	end
end