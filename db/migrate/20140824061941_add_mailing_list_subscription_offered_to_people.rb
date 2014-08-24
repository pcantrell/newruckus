class AddMailingListSubscriptionOfferedToPeople < ActiveRecord::Migration
  def change
    add_column :people, :mailing_list_subscription_offered, :boolean, default: false, null: false
  end
end
