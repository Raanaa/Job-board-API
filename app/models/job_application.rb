class JobApplication < ApplicationRecord
    belongs_to :user
    belongs_to :job
    validates_presence_of :status

    after_initialize :set_defaults, unless: :persisted?
    def set_defaults
        self.status  ||= 'not_seen'
    end
end
