module ApplicationHelper
	def language_flag
    flag = %w(https://res.cloudinary.com/muhammadyana/image/upload/v1512641507/al-mizan/US.png https://res.cloudinary.com/muhammadyana/image/upload/v1512641511/al-mizan/ID.png https://res.cloudinary.com/muhammadyana/image/upload/v1512641511/al-mizan/SA.png)
  end

  def current_language_flag
    if locale_nation(I18n.locale).eql? 'English'
      image_local = image_tag language_flag[0]
    elsif locale_nation(I18n.locale).eql? 'Indonesia'
    	image_local = image_tag language_flag[1]
    elsif locale_nation(I18n.locale).eql? 'Arabic'
      image_local = image_tag language_flag[2]
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
    images = %w(https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617055/assets/banner/home-v3.jpg  https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617114/assets/banner/home-indoexchanger.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1200/v1511617351/assets/banner/indo-home-v2.jpg https://res.cloudinary.com/indoexchanger/image/upload/c_scale,w_1000/v1511654797/assets/banner/indoexchanger-stamp-pen.jpg)
    return images.sample
  end

  def random_image_home
    images = %w(https://res.cloudinary.com/muhammadyana/image/upload/v1512700816/al-mizan/background/13781848_1133994316658636_2663626792748662069_n.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512631618/al-mizan/background/13776027_1133994073325327_6243295768723387211_n.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512631708/al-mizan/background/silaturrahmi-4.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512632320/al-mizan/background/14330073_1179143412143726_4215595160823234128_n.jpg)
    return images.sample
  end

  def locale_nation(locale)
    case locale
	    when :id
	      "Indonesia"
	    when :en
	      "English"
      when :sa
        "Arabic"
    end
  end
end
