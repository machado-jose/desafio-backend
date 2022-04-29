class RegisterExpenseDeputyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "RegisterExpenseDeputyChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
