class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      name: name,
      email: email,
      balance: balance
    }
    #code
  end
  #code
end
