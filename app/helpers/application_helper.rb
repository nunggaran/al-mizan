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
    %W(sejarah visi about_us cara_registrasi_akun)
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

  def random_image_mudir
    images = %w(https://res.cloudinary.com/al-mizan/image/upload/v1512879375/assets/image/20121206_1495176167207114_2865656083753650746_o.jpg https://res.cloudinary.com/al-mizan/image/upload/v1512880013/assets/image/mudir/21768611_1559954467395950_3594649337201265197_o.jpg https://res.cloudinary.com/al-mizan/image/upload/v1512880140/assets/image/mudir/20287018_1502939379764126_1449802719593899123_o.jpg https://res.cloudinary.com/al-mizan/image/upload/v1512880159/assets/image/mudir/20280540_1502939066430824_4309184607117713317_o.jpg https://res.cloudinary.com/al-mizan/image/upload/v1512880206/assets/image/mudir/20280408_1502938859764178_721041377275057100_o.jpg https://res.cloudinary.com/al-mizan/image/upload/v1512880250/assets/image/mudir/20106502_1494377470620317_6161044047394628790_n.jpg)
    return images.sample
  end

  def random_image_activiy
    images = %w(https://res.cloudinary.com/muhammadyana/image/upload/c_scale,h_450/v1512717261/al-mizan/activity/KMD-6.jpg https://res.cloudinary.com/muhammadyana/image/upload/c_scale,h_450/v1512717250/al-mizan/activity/KMD-5.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717236/al-mizan/activity/14212078_1172167089508025_2667288149476048747_n.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717505/al-mizan/activity/14064071_1159726490752085_4614359848663542672_n.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717747/al-mizan/activity/fata3.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717188/al-mizan/activity/da1.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717647/al-mizan/activity/UTS3.jpg https://res.cloudinary.com/muhammadyana/image/upload/v1512717591/al-mizan/activity/14729238_1069258419862201_117536813428468076_n.jpg)
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
