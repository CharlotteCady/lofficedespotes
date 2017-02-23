class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  # def welcome
  #   @greeting = "Bonjour"

  #   mail to: "to@example.org"
  # end

  def welcome(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Bienvenu chez WorkUp')
    # This will render a view in `app/views/user_mailer`!
  end

  def new_event(event)
    @event = event
    mail(to: "team@workup.rocks", subject: "Nouvel événement à modérer")
  end

  def moderated_event(event)
    @event = event
    @user = User.find(@event.user)
    mail(to: @user.email, subject: "Votre événement est en ligne sur WorkUp")
  end
end
