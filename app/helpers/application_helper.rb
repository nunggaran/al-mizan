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

  def year_of_entry
    
  end

  def article_action
    %w(index show)
  end

  def user_action
    %w(edit show)
  end

  def gravatar_for(user, class_names=nil, options = { size: 500 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: class_names)
  end

  def action_array
    %W(sejarah visi about_us ekskul facility)
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

  def random_image_activity
    images = %w(
    https://res.cloudinary.com/al-mizan/image/upload/v1512975829/assets/image/activity/22730347_1591278460930217_3385631058869855206_n.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512975845/assets/image/activity/22730298_1591278550930208_8752086244225043584_n.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512975858/assets/image/activity/22780613_1591278340930229_8252693925058034813_n.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512975876/assets/image/activity/22853200_1591278244263572_3965036959167497148_n.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512975891/assets/image/activity/21949764_1559957360728994_1242150528655346496_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512975917/assets/image/activity/21765446_1559975894060474_8401009349102770836_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976012/assets/image/activity/20900930_1525753787482685_3357845643079196596_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976034/assets/image/activity/20819195_1521673667890697_5232958725158135955_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976101/assets/image/activity/20229506_1498345613556836_6183717061450338100_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976171/assets/image/activity/20231993_1498344526890278_8985095132485654138_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976130/assets/image/activity/20286956_1498345756890155_1366784682701074905_o.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976206/assets/image/activity/20106795_1494377300620334_4670981028455408848_n.jpg
    https://res.cloudinary.com/al-mizan/image/upload/v1512976286/assets/image/activity/18451351_1426681804056551_3519874375527151151_o.jpg
    )
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
