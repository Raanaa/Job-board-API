class UpdateJobApplicationTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :job_applications, :user, foreign_key: true
  end
end
