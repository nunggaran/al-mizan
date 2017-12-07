module ApplicationHelper
	def language_flag
    flag = %w(https://s3-ap-southeast-1.amazonaws.com/indoexchanger/flag/US.png https://s3-ap-southeast-1.amazonaws.com/indoexchanger/flag/ID.png)
  end

  def current_language_flag
    if locale_nation(I18n.locale).eql? 'English'
      image_local = image_tag language_flag[0]
    elsif locale_nation(I18n.locale).eql? 'Indonesia'
    	image_local = image_tag language_flag[1]
    end
    return image_local
  end

  def action_array
    %W(cara_mendapatkan_bitcoin about_us cara_registrasi_akun)
  end

  def amount_btc
    response = HTTParty.post('https://indoexchanger.co.id/private/rest/indoExchanger/amountBitcoin', format: :plain)
    parsing = JSON.parse response
    Rails.logger.info("#{parsing} yeah.. 🎉")
    return parsing
  end
  
  def amount_btc
    response = HTTParty.post('https://indoexchanger.co.id/private/rest/indoExchanger/amountBitcoin', format: :plain)
    parsing = JSON.parse response
    # Rails.logger.info("#{parsing} yeah.. 🎉")
    return parsing
  end

  def amount_params
    [
      {
        amount_idr: amount_btc["amountIDR"],
        amount_usd: amount_btc["amountUSD"],
        time:       amount_btc["time"]
      }
    ]
  end

  def random_image_header
    images = %w(https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617055/assets/banner/home-v3.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617114/assets/banner/home-indoexchanger.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617351/assets/banner/indo-home-v2.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1000/v1511654797/assets/banner/indoexchanger-stamp-pen.jpg)
    return images.sample
  end

  def random_image_home
    images = %w(https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_955/v1509841042/banner-app_tlpilu.jpg https://res.cloudinary.com/indoexchanger/image/upload/q_40/v1509841228/banner-app-iex-2_pcr04i.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1310/v1509851946/home-mobile-1_hnye3g.jpg)
    return images.sample
  end

  def locale_nation(locale)
    case locale
	    when :id
	      "Indonesia"
	    when :en
	      "English"
    end
  end
end
