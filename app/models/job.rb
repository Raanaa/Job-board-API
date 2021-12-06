class Job < ApplicationRecord
    belongs_to :user
    has_many :job_applications , dependent: :destroy
    validates_presence_of :title, :description, :company
end
