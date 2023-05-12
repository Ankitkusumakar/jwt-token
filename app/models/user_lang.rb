class UserLang < ApplicationRecord
    belongs_to :user
    belongs_to :lang
end
