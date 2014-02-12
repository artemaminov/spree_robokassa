Spree::Order.class_eval do

  state_machine do
    before_transition :to => :complete, :do => :valid_zip_code?
  end

  def valid_zip_code?
    false
  end

end