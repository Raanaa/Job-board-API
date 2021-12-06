class UpdateJobapplicationTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :job_applications, :job, foreign_key: true
  end
end
