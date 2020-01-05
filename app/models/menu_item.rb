class MenuItem < ApplicationRecord
  belongs_to :navigation, as: :polymorphic
end
