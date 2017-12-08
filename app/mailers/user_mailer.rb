class UserMailer < ApplicationMailer
	default :from => 'Ponpes Modern Al-Mizan <no-reply@al-mizan.sch.id>'
	layout 'mailer'
	def contact_mailer(first_name, last_name, email, message)
		subject = "Contact Admin Al-Mizan "
		@full_name = "#{first_name} #{last_name}"
		@from = email
		@message = message
		mail(to: ['muhammadyanaa@gmail.com'], subject: "Question from #{@full_name}")
	end

end
