class CreateJobApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :job_applications do |t|
      t.string :status

      t.timestamps
    end
  end
end
