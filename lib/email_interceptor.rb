class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "E-mail de Bienvenu"
    message.to = [ 'charlotte.cady@hotmail.fr' ]
  end
end