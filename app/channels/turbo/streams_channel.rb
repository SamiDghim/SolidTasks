class Turbo::StreamsChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:signed_stream_name]
  end
end
