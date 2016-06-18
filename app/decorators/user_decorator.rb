class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      name: name,
      email: email
    }
    #code
  end
  #code
end
