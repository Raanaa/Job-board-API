FactoryBot.define do
    factory :job_application do
      status { "not_seen" }
      user { create(:user) }
      job { create(:job) }
    end
  end