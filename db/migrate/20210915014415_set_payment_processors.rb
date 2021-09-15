class SetPaymentProcessors < ActiveRecord::Migration[6.1]
  # Set user's payment processor
  def up
    User.all.each do |user|
      user.set_payment_processor :stripe
    end
  end

  # Do nothing in the opposite direction
  def down; end
end
