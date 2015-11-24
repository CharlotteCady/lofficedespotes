class User < ActiveRecord::Base
  after_create :subscribe_to_newsletter

  private

  def subscribe_to_newsletter
    SubscribeToNewsletter.new(self).run
  end
end