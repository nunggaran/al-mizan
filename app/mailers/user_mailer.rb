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

	def new_alumni_registration(first_name, last_name, email, angkatan, address, username, job, handphone, university, faculty)
		@full_name = "#{first_name} #{last_name}"
		subject = "New Alumni Mizan Registration #{@full_name}"
		@email = email
		@angkatan = angkatan
		@address = address
		@username = username
		@job = job
		@handphone = handphone
		@university = university
		@faculty = faculty
		mail(to: ['muhammadyanaa@gmail.com'], subject: subject)
	end

	def announcement(first_name, last_name, email, message)
		subject = "Update from Al-Mizan Website"
		@recipient = email
		@full_name = "#{first_name} #{last_name}"
		@message = message
		mail(to: @recipient, subject: subject)
	end

end
