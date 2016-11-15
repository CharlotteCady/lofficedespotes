# ForestLiana::ApplicationController takes care of the authentication for you.

class StatsController < ForestLiana::ApplicationController
  # def total_user_login
  #   stat = ForestLiana::Model::Stat.new({
  #     value: 500000 # Your business logic here.
  #   })

  #   # The serializer_model function serializes the ForestLiana::Model::Stat
  #   # model to a valid JSONAPI payload.
  #   render json: serialize_model(stat)
  # end

  def age_repartition
    # Your business logic here.
    # if user.birthday?
    #   user_age = Date.today.year - user.birthday
      # (user.birthday à convertir en année)
      # age_range = array de tranche d'âge à définir

      value =  [
  { key: 'aaa', value: 111 },
  { key: 'bbb', value: 222 }
]

      stat = ForestLiana::Model::Stat.new({
        value: value
      })

      # The serializer_model function serializes the ForestLiana::Model::Stat
      # model to a valid JSONAPI payload.
      render json: serialize_model(stat)
    # end
  end
end